variable "storage_size" {
    type = number
    default = "20"
}

variable "db_identifier" {
  type = string
  default = ""
}

variable "storage_type" {
  default = "gp2"
}

variable "storage_encrypted" {
  description = "Specifies whether the DB instance is encrypted"
  type        = bool
  default     = true
}

variable "db_engine" {
  default = "aurora-postgresql"
}

variable "engine_version" {
  type = string
  default = "12.3"
}

variable "db_instance_class" {
  type = string
  default = "db.t2.micro"
}

variable "db_name" {
  type = string
  default = ""
}

variable "db_user" {
  type = string
  default = ""
}

variable "db_password" {
  type = string
  default = ""
}

variable "db_para_group" {
  type = string
  default = ""
}

variable "db_vpc" {
type = string
default = "data.aws_vpc.demo.id"
}

#variable "db_subnet_group_name" {
#  description = "Name of DB subnet group"
#  type        = string
#  default     = ""
#}