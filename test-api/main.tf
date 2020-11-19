provider "aws" {
  region = "us-east-2"
}

locals {
  common_tags = {
    Project     = var.project
    Environment = var.environment
    CreatedBy   = "Terraform"
  }
}

module "API-Gateway" {
  source                           = "./module/"
  project                          = var.project
  environment                      = var.environment
  common_tags                      = local.common_tags
}