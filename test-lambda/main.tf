provider "aws" {
  region = "us-east-2"
}


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
}