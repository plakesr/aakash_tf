variable "frontend_ecr_repo" {
  description = "frontend ecr repo"
}

variable "frontend_image_tag" {
  description = "frontend image tag"
}

variable "frontend_memory" {
  description = "frontend container memory"
}

variable "frontend_cpu" {
  description = "frontend container cpu"
}

variable "frontend_container_port" {
  description = "frontend container port"
}

variable "ecs_launch_type" {
  description = "ecs launch type"
}

variable "ecs_frontend_scheduling_strategy" {
  description = "ecs frontend scheduling strategy"
}

variable "private_subnet_ids" {
  description = "private subnet ids"
  type = list
}

variable "backend_ecr_repo" {
  description = "backend ecr repo"
}

variable "backend_image_tag" {
  description = "backend container image tag"
}

variable "backend_memory" {
  description = "backend container memory"
}

variable "backend_cpu" {
  description = "backend container cpu"
}

variable "backend_container_port" {
  description = "backend container port"
}

variable "ecs_backend_scheduling_strategy" {
  description = "ecs backend scheduling strategy"
}

variable "ecs_frontend_desired_count" {
  description = "ecs frontend desired no. of containers"
}

variable "ecs_backend_desired_count" {
  description = "ecs backend desired no. of containers"
}