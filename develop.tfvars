aws_assume_role = "arn:aws:iam::127162141075:role/svc_atlantis"
env             = "dev"
aws_region      = "us-west-2"
aws_name        = "demo-vpc"

#####_varibale_values_for_rds_dev_env##
storage_size      = "20"
storage_type      = "gp2"
storage_encrypted = "true"
db_engine         = "postgres"
engine_version    = "12.4"
db_instance_class = "db.t2.micro"
db_name           = "postgres_db"
db_user           = "demo"
db_password       = "password123"
db_para_group     = "default"
db_identifier     = "demo-db"
#db_subnet_group_name = "db_subnet_group_name"

######## Variable for Lambda
filename = "hello.zip"
function_name = "dev_lambda"
memory_size = "128"
tagname = "dev_mgm_lambda"