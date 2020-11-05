provider "aws" {
  region = "us-east-2"
}

data "aws_vpc" "demo" {
filter {
    name = "tag:Name"
    values = ["${var.aws_name} VPC"]
  }
}

data "aws_subnet" "private_A" {
vpc_id = data.aws_vpc.demo.id
filter {
    name   = "tag:Name"
    values = ["${var.aws_name} PRIVATE A"] # insert value here
  }
}

data "aws_subnet" "private_B" {
vpc_id = data.aws_vpc.demo.id
filter {
    name   = "tag:Name"
    values = ["demo-vpc PRIVATE B"] #insert value here "^p.*11$" ["${var.aws_name}" "PRIVATE" "*"]
  }
}

resource "aws_db_subnet_group" "default" {
 name       = "my_sub_grp"
 subnet_ids = [data.aws_subnet.private_A.id, data.aws_subnet.private_B.id] #tolist(concat("${data.aws_subnet.private_A.id}", "${data.aws_subnet.private_B.id}")) 

 tags = {
   Name = "private subnet group"
  }
}

#####main_variables_for_rds_setup
variable "storage_size" {}
variable "storage_type" {}
variable "db_engine" {}
variable "engine_version" {}
variable "db_instance_class" {}
variable "db_name" {}
variable "db_user" {}
variable "db_password" {}
variable "db_para_group" {}
variable "db_identifier" {}
variable "aws_name" {}


######RDS_module
module "rds-postgres" {
    source = "./modules/rds-postgres"
    db_identifier = var.db_identifier
    storage_size = var.storage_size
    storage_type = var.storage_type
    db_engine = var.db_engine
    engine_version = var.engine_version
    db_instance_class = var.db_instance_class
    db_name = var.db_name
    db_user = var.db_user
    db_password = var.db_password
    db_para_group = var.db_para_group
    
}

