output "rds-end-point" {
  value = aws_db_instance.dev-rds.endpoint
}

output "rds-identifier" {
  value = aws_db_instance.dev-rds.identifier
}