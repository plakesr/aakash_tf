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
  filename      = var.zip_file
  function_name = var.lambda_function
  role          = aws_iam_role.lambda_function_role.arn
  handler       = "lambda_function.lambda_handler"
  memory_size   = var.lambda_memorysize
  source_code_hash = filebase64sha256(file(var.zip-file))
  runtime = "python3.8"

  environment {
    variables = {
      tagname = var.tagname
    }
  }
}