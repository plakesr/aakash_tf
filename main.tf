provider "aws" {
  region = "us-east-2"
}

data "aws_caller_identity" "current" {}

data "aws_canonical_user_id" "current" {}

#Local Vars 
variable "project" {}
variable "environment" {}
variable "backend_allowed_cidrs" {}
variable "backend_lb_allowed_cidrs" {}
variable "allow_methods" {}
variable "cache_methods" {}
variable "static_s3_expiration_days" {}
variable "s3_acl_bucket" {}
#variable "vpc_id" {}
variable "deregistration_delay" {}
variable "health_check_path" {}
variable "public_subnet_ids" {}
variable "region" {}
variable "certificate_arn_no" {}
variable "ecs_backend_desired_count" {}
variable "ecs_launch_type" {}
variable "backend_memory" {}
variable "backend_cpu" {}
variable "backend_container_port" {}
variable "ecs_backend_scheduling_strategy" {}


















##########-Getting-VPC/Subnets/-Details 
locals {
  private_subnet = [for subnet_info in data.aws_subnet.private_subnet : subnet_info.id if split(" ", subnet_info.tags.Name)[1] == "PRIVATE"]
  pub_cidr       = [for subnet_info in data.aws_subnet.private_subnet : subnet_info.cidr_block if split(" ", subnet_info.tags.Name)[1] == "PUBLIC"]
  cloudfront_origin_access_identity = "access-identity-${var.project}-static-s3-${var.environment}.s3.amazonaws.com"
  fqdn = "S3-${var.project}-static-s3-${var.environment}"
  #cname = ["${var.project}-frontend-${var.environment}.${var.domain_name}"]
  s3bucket_domain_name = "${var.project}-static-s3-${var.environment}.s3.amazonaws.com"
  account_id = data.aws_caller_identity.current.account_id
  #cert_arn = "arn:aws:acm:us-east-1:${local.account_id}:certificate/${var.cf_certificate_arn_no}"
  common_tags = {
    Project     = var.project
    Environment = var.environment
    CreatedBy   = "Terraform"
  }
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
  count = length(flatten(list(data.aws_subnet_ids.private_sub.ids)))
  id    = flatten(list(data.aws_subnet_ids.private_sub.ids))[count.index]
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
  source                 = "./modules/rds-postgres"
  db_identifier          = var.db_identifier
  storage_size           = var.storage_size
  storage_type           = var.storage_type
  storage_encrypted      = var.storage_encrypted
  db_engine              = var.db_engine
  engine_version         = var.engine_version
  db_instance_class      = var.db_instance_class
  db_name                = var.db_name
  db_user                = var.db_user
  db_password            = var.db_password
  db_para_group          = var.db_para_group
  subnet_ids             = local.private_subnet
  vpc-security-group-ids = [module.sg2.aws_security_group_default]
}

#######Security-Grps
module "sg1" {
  source              = "./modules/aws-sg-cidr"
  project                           = var.project
  environment                       = var.environment
  namespace           = "demo-ecs"
  stage               = "dev"
  name                = "ecs"
  tcp_ports           = "22,80,443"
  #cidrs               = ["111.119.187.1/32"]
  security_group_name = "ecs"
  vpc_id              = data.aws_vpc.demo.id
  backend_allowed_cidrs             = var.backend_allowed_cidrs
  backend_lb_allowed_cidrs          = var.backend_lb_allowed_cidrs
  common_tags                       = local.common_tags
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

############ Module for cloudfront
module "cloudfront" {
  source                            = "./modules/CloudFront/"
  bucket_regional_domain_name       = local.s3bucket_domain_name
  cloudfront_origin_access_identity = local.cloudfront_origin_access_identity
  fqdn                              = local.fqdn
  common_tags                       = local.common_tags
  project                           = var.project
  environment                       = var.environment
  cloudfront_default_certificate    = true
  #aliases                           = local.cname
  #cert_arn                          = local.cert_arn
  #ssl_method                        = var.ssl_method
  #protocol_version                  = var.protocol_version
  allow_methods                     = var.allow_methods
  cache_methods                     = var.cache_methods
  #waf_acl_id                        = module.WAF.waf_acl_id
}

######## Module for S3 static bucket
module "static-s3" {
  source                            = "./modules/S3/"
  environment                       = var.environment
  project                           = var.project
  s3_bucket                         = "static-s3"
  common_tags                       = local.common_tags
  expiration_days                   = var.static_s3_expiration_days
  cf_canonical_user_id              = module.cloudfront.cf_arn
  s3_acl_bucket                     = var.s3_acl_bucket
}


######### Module for LoadBalancer-ALB
module "LoadBalancer" {
  source                            = "./modules/alb/"
  project                           = var.project
  environment                       = var.environment
  vpc_id                            = var.vpc_id
  frontend_lb_sg_id                 = [module.Security.backend_lb_sg_id]
  deregistration_delay              = var.deregistration_delay
  health_check_path                 = var.health_check_path
  public_subnet_ids                 = var.public_subnet_ids
  region                            = var.region
  account_id                        = data.aws_caller_identity.current.id
  certificate_arn_no                = var.certificate_arn_no
  common_tags                       = local.common_tags
}

######### Module for ECS-Backend
module "ECS" {
  source                           = "./modules/ecs/"
  project                          = var.project
  environment                      = var.environment
 # account_id                       = data.aws_caller_identity.current.id
  common_tags                      = local.common_tags
  #region                           = var.region
  ecs_backend_desired_count        = var.ecs_backend_desired_count
  ecs_launch_type                  = var.ecs_launch_type
  ecs_backend_role_arn             = module.sg1.backend_role_arn
  #private_subnet_ids               = var.private_subnet_ids
  subnet_ids             = local.private_subnet
  #backend_ecr_repo                 = var.backend_ecr_repo
  #backend_image_tag                = var.backend_image_tag
  backend_memory                   = var.backend_memory
  backend_cpu                      = var.backend_cpu
  backend_lb_target_group_arn      = module.LoadBalancer.alb_target_group_arn
  backend_container_port           = var.backend_container_port
  ecs_backend_scheduling_strategy  = var.ecs_backend_scheduling_strategy
  sg1           = module.sg1
}