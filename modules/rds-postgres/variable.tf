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