variable "filename" {
    type = string
    default = ""
}

variable "function_name" {
    type = string
    default = ""
}

variable "memory_size" {
    type = number
    default = "128"
}

variable "tagname" {
    type = string
    default = ""
}

variable "subnet_ids" {
  description = "A list of VPC Subnet IDs to launch in"
  type        = list(string)
  default     = []
}

variable "sg_id" {
   default = ""
}


/*
variable "lambda_function" {
    type = string
    default = ""
}

variable "lambda_function" {
    type = string
    default = ""
}

variable "lambda_function" {
    type = string
    default = ""
}
*/