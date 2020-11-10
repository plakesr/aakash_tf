/*
variable "name" {}
variable "vpc_id" {}
variable "ports" {}
variable "sg_name" {}
variable "cidr_range" {}


module "rds_sg" {
  source              = "./modules/rds-sg"
  name                = var.name
  description         = "PostgreSQL open ports"
  vpc_id              = var.vpc_id
  tcp_ports           = var.ports
  security_group_name = var.sg_name
  cidrs               = var.cidr_range
}
*/