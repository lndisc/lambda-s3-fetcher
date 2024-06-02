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

resource "aws_s3_object" "bye_world" {
  bucket = aws_s3_bucket.this.bucket
  key    = "bye-world.txt"
  source = "${path.module}/files/bye-world.txt"
  acl    = "private"
}

# IAM role for lambda

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "s3_access" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.this.arn}/${aws_s3_object.hello_world.key}"]
  }
}

resource "aws_iam_policy" "s3_access" {
  name        = "s3_access"
  description = "Policy for allowing Lambda to access S3"
  policy      = data.aws_iam_policy_document.s3_access.json
}

resource "aws_iam_role_policy_attachment" "lambda_s3_attach" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.s3_access.arn
}

# Archive the Lambda function code
data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/lambda/lambda_function.py"
  output_path = "${path.module}/lambda/lambda_function.zip"
}

# Lambda function
resource "aws_lambda_function" "hello_world_lambda" {
  filename      = data.archive_file.lambda.output_path
  function_name = var.lambda_function_name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime
  source_code_hash = data.archive_file.lambda.output_base64sha256
}

# Invoking the Lambda function
data "aws_lambda_invocation" "invoke_lambda" {
  function_name = aws_lambda_function.hello_world_lambda.arn
  input = jsonencode({
    "bucket_name": var.bucket_name,
    "object_key": "${aws_s3_object.hello_world.key}"
  })
}