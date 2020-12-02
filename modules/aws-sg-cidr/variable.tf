variable "namespace" {
  type        = string
  description = "Namespace (e.g. `eg` or `cp`)"
  default     = ""
}

variable "stage" {
  type        = string
  description = "Stage (e.g. `prod`, `dev`, `staging`)"
  default     = ""
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `name`, `namespace`, `stage` and `attributes`"
}

variable "enabled" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  default     = ""
}


variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "tcp_ports" {
  type = string
  default = "default_null"
}

variable "udp_ports" {
  default = "default_null"
}



variable "backend_allowed_cidrs" {
  description = "backend allowed cidrs for ecs service"
}

variable "backend_lb_allowed_cidrs" {
  description = "frontend load balancer allowed cidrs"
  type = list
}

variable "common_tags" {
  description = "common tags for all resources"
  type = map
}

variable "project" {
  description = "name of the project"
}

variable "environment" {
  description = "name of the environment"
}
#variable "cidrs" {
#  type = list(string)
#}

variable "security_group_name" {}

variable "vpc_id" {}