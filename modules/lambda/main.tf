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

resource "aws_iam_role_policy_attachment" "AWSLambdaVPCAccessExecutionRole" {
    role       = aws_iam_role.lambda_function_role.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

 resource "aws_lambda_function" "mgm_lambda" {
  filename      = var.filename
  function_name = var.function_name
  role          = aws_iam_role.lambda_function_role.arn
  handler       = "lambda_function.lambda_handler"
  memory_size   = var.memory_size
  source_code_hash = filebase64sha256(var.filename)
  runtime = "python3.8"

  environment {
    variables = {
      tagname = var.tagname
    }
  }
  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.sg_id
  }
}