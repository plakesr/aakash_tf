resource "aws_iam_role" "lambda_function_role" {
  name = "lambda_function_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "mgm_lambda" {
  filename      = var.filename
  function_name = var.function_name
  role          = aws_iam_role.lambda_function_role.arn
  handler       = "lambda_function.lambda_handler"
  memory_size   = var.memory_size
 # source_code_hash = "${filebase64sha256(file(var.filename))}"
  runtime = "python3.8"
  #db_subnet_group_name = aws_db_subnet_group.rds-instance-subnets.name
  #vpc_security_group_ids = var.vpc-security-group-ids
#vpc_config {
    #subnet_ids         = ["${var.subnet_ids}"]
    #security_group_ids = ["${var.security_group_ids}"]
 # }
  environment {
    variables = {
      tagname = var.tagname
    }
  }
}
#