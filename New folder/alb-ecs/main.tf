provider "aws" {
  region = var.region
}


module "LoadBalancer" {
  source                    = "./alb/"
  project                   = var.project
  environment               = var.environment
  vpc_id                    = var.vpc_id
  frontend_lb_sg_id         = [module.security.frontend_lb_sg_id]
  deregistration_delay      = var.deregistration_delay
  health_check_path         = var.health_check_path
  public_subnet_ids         = var.public_subnet_ids
  region                    = var.region
  account_id                = data.aws_caller_identity.current.id
  certificate_arn_no        = var.certificate_arn_no
  common_tags               = local.common_tags
}

module "ECS" {
  source                           = "./ecs/"
  project                          = var.project
  environment                      = var.environment
  account_id                       = data.aws_caller_identity.current.id
  common_tags                      = local.common_tags
  region                           = var.region
  frontend_lb_target_group_arn     = module.LoadBalancer.alb_target_group_arn
  frontend_ecr_repo                = var.frontend_ecr_repo
  frontend_image_tag               = var.frontend_image_tag
  frontend_memory                  = var.frontend_memory
  frontend_cpu                     = var.frontend_cpu
  frontend_container_port          = var.frontend_container_port
  ecs_frontend_desired_count       = var.ecs_frontend_desired_count
  ecs_backend_desired_count        = var.ecs_backend_desired_count
  ecs_frontend_role_arn            = module.security.frontend_role_arn
  ecs_launch_type                  = var.ecs_launch_type
  ecs_backend_role_arn             = module.security.backend_role_arn
  ecs_frontend_scheduling_strategy = var.ecs_frontend_scheduling_strategy
  frontend_security_group          = module.security.frontend_sg_id
  private_subnet_ids               = var.private_subnet_ids
  backend_ecr_repo                 = var.backend_ecr_repo
  backend_image_tag                = var.backend_image_tag
  backend_memory                   = var.backend_memory
  backend_cpu                      = var.backend_cpu
  backend_container_port           = var.backend_container_port
  ecs_backend_scheduling_strategy  = var.ecs_backend_scheduling_strategy
  backend_security_group           = module.security.backend_sg_id
}