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
#variable "db_subnet_group_name" {}


######RDS_module
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
  #db_subnet_group_name = var.db_subnet_group_name


  #subnet_ids = 
}