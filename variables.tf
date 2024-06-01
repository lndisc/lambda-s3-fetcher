variable "aws_region" {
  description = "The AWS region where resources will be created."
  type        = string
  default     = "eu-west-1"
}

variable "bucket_name" {
  description = "The name of the S3 bucket."
  type        = string
}

variable "lambda_name" {
  description = "The name of the Lambda function."
  type        = string
}