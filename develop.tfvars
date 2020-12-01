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

### S3 variables
project = "mgm"
region = "us-west-2"
environment = "dev"
#domain_name = "mgm.com"
#cf_certificate_arn_no = ""
#waf_cidr_allowlist = ["0.0.0.0/"]
#ssl_method = "sni-only"
#protocol_version = "TLSv1.2_2019"
s3_acl_bucket = "private"
allow_methods = ["HEAD", "DELETE", "POST", "GET", "OPTIONS", "PUT", "PATCH"]
cache_methods = ["GET","HEAD"]
static_s3_expiration_days = "90"

######### ECS variable
backend_allowed_cidrs = []
backend_lb_allowed_cidrs = []
deregistration_delay = ""
health_check_path = ""
public_subnet_ids = []
certificate_arn_no = ""
ecs_launch_type = "FARGATE"
private_subnet_ids = []
backend_ecr_repo = ""
backend_image_tag = ""
backend_memory = ""
backend_cpu = ""
backend_container_port = ""
ecs_backend_scheduling_strategy = "REPLICA"
ecs_backend_desired_count = "1"
