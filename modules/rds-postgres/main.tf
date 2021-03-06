resource "aws_db_instance" "dev-rds" {
  identifier           = var.db_identifier
  allocated_storage    = var.storage_size
  storage_type         = var.storage_type
  engine               = var.db_engine
  engine_version       = var.engine_version
  instance_class       = var.db_instance_class
  name                 = var.db_name
  username             = var.db_user
  password             = var.db_password
  skip_final_snapshot  = true
  
}




