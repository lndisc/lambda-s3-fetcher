# S3 Bucket

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
}

resource "aws_s3_object" "hello_world" {
  bucket = aws_s3_bucket.this.bucket
  key    = "hello-world.txt"
  source = "${path.module}/files/hello-world.txt"
  acl    = "private"
}

# IAM role for lambda

data "aws_iam_policy_document" "lambda_s3_access" {
  statement {
    actions   = ["s3:GetObject"]
    resources = [aws_s3_bucket.this.arn + "/*"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.lambda_s3_access.json
}
/*
resource "aws_lambda_function" "hello_world_lambda" {
  filename      = "${path.module}/files/lambda_function.py"
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_exec.arn
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime
}
