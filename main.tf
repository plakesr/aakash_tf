provider "aws" {
  region = "us-east-2"
}

##########-Getting-VPC/Subnets/-Details 
locals {
    private_subnet = [for subnet_info in data.aws_subnet.private_subnet: subnet_info.id if split(" ",subnet_info.tags.Name)[1] == "PRIVATE"]
    pub_cidr = [for subnet_info in data.aws_subnet.private_subnet: subnet_info.cidr_block if split(" ",subnet_info.tags.Name)[1] == "PUBLIC"]
}


data "aws_vpc" "demo" {
  filter {
    name   = "tag:Name"
    values = ["${var.aws_name} VPC"]
  }
}

data "aws_subnet_ids" "private_sub" {
  vpc_id = data.aws_vpc.demo.id
}

data "aws_subnet" "private_subnet" {
  count  = length(flatten(list(data.aws_subnet_ids.private_sub.ids)))
  id = flatten(list(data.aws_subnet_ids.private_sub.ids))[count.index]
}


#####main_variables_for_rds_setup
variable "storage_size" {}
variable "storage_type" {}
variable "storage_encrypted" {}
variable "db_engine" {}
variable "engine_version" {}
variable "db_instance_class" {}
variable "db_name" {}
variable "db_user" {}
variable "db_password" {}
variable "db_para_group" {}
variable "db_identifier" {}
variable "aws_name" {}

#####RDS_module
module "rds-postgres" {
  source               = "./modules/rds-postgres"
  db_identifier        = var.db_identifier
  storage_size         = var.storage_size
  storage_type         = var.storage_type
  storage_encrypted    = var.storage_encrypted
  db_engine            = var.db_engine
  engine_version       = var.engine_version
  db_instance_class    = var.db_instance_class
  db_name              = var.db_name
  db_user              = var.db_user
  db_password          = var.db_password
  db_para_group        = var.db_para_group
  subnet_ids           = local.private_subnet
  vpc-security-group-ids = [module.sg2.aws_security_group_default]
}

#######Security-Grps
module "sg1" {
  source              = "./modules/aws-sg-cidr"
  namespace           = "demo-ecs"
  stage               = "dev"
  name                = "ecs"
  tcp_ports           = "22,80,443"
  cidrs               = ["111.119.187.1/32"]
  security_group_name = "ecs"
  vpc_id              = data.aws_vpc.demo.id
}

module "sg2" {
  source                  = "./modules/aws-sg-ref-v2"
  namespace               = "demo-rds"
  stage                   = "dev"
  name                    = "rds"
  tcp_ports               = "5432"
  ref_security_groups_ids = [module.sg1.aws_security_group_default]
  security_group_name     = "rds"
  cidrs_rds               = local.pub_cidr
  vpc_id                  = data.aws_vpc.demo.id
}

######################

module "lambda_test"{
  source = "./modules/lambda"
}