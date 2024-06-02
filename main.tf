resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
}

resource "aws_s3_object" "hello_world" {
  bucket = aws_s3_bucket.this.bucket
  key    = "hello-world.txt"
  source = "${path.module}/files/hello-world.txt"
  acl    = "private"
}

resource "aws_lambda_function" "hello_world_lambda" {
  filename      = "${path.module}/lambda/lambda_function.py"
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_exec.arn
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime
}

resource "aws_iam_role" "lambda_exec" {
  name = var.lambda_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_s3_attach" {
  policy_arn = aws_iam_policy.lambda_s3_access.arn
  role       = aws_iam_role.lambda_exec.name
}

resource "aws_iam_policy" "lambda_s3_access" {
  name = "lambda-s3-access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Action    = "s3:GetObject"
      Resource  = aws_s3_bucket.this.arn + "/*"
    }]
  })
}
