provider "aws" {
  region = "us-east-2"
}
/*
##########-Getting-VPC/Subnets/-Details 
locals {
  private_subnet = [for subnet_info in data.aws_subnet.private_subnet : subnet_info.id if split(" ", subnet_info.tags.Name)[1] == "PRIVATE"]
  pub_cidr       = [for subnet_info in data.aws_subnet.private_subnet : subnet_info.cidr_block if split(" ", subnet_info.tags.Name)[1] == "PUBLIC"]
}
*/

#data "aws_vpc" "demo" {
#  filter {
#    name   = "tag:Name"
#    values = ["${var.aws_name} VPC"]
#  }
#}

#data "aws_subnet_ids" "private_sub" {
  #vpc_id = data.aws_vpc.demo.id
#}

#data "aws_subnet" "private_subnet" {
#  count = length(flatten(list(data.aws_subnet_ids.private_sub.ids)))
#  id    = flatten(list(data.aws_subnet_ids.private_sub.ids))[count.index]
#}
######## Variable for Lambda
variable "filename" {}
variable "function_name" {}
variable "memory_size" {}
variable "tagname" {}
######### module for Lambda###

module "mgm_lambda_module"{
  source = "./lambda"
  filename      = var.filename
  function_name = var.function_name
  memory_size   = var.memory_size
  tagname = var.tagname
  # subnet_ids             = local.private_subnet
  #vpc-security-group-ids = [module.sg2.aws_security_group_default]
}