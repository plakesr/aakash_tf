
resource "aws_db_instance" "dev-rds" {
  identifier           = var.db_identifier
  allocated_storage    = var.storage_size
  storage_type         = var.storage_type
 # storage_encrypted    = var.storage_encrypted
  engine               = var.db_engine
  engine_version       = var.engine_version
  instance_class       = var.db_instance_class
  name                 = var.db_name
  username             = var.db_user
  password             = var.db_password
  skip_final_snapshot  = true
  multi_az             = true
  db_subnet_group_name = aws_db_subnet_group.rds-instance-subnets.name
  vpc_security_group_ids = var.vpc-security-group-ids
}

resource "aws_db_subnet_group" "rds-instance-subnets" {
  name                 = var.db_name
  subnet_ids           = var.subnet_ids
}




