variable "bucket_name" {
  description = "The name of the S3 bucket."
  type        = string
}

variable "object_key" {
  description = "The name of the file to be fetched"
  type = string
  default = "hello-world.txt"
}

variable "aws_region" {
  description = "The AWS region to create resources in."
  type        = string
  default     = "eu-west-1"
}

variable "lambda_function_name" {
  description = "The name of the Lambda function."
  type        = string
  default     = "HelloWorldLambda"
}

variable "lambda_handler" {
  description = "The name of the Lambda handler function."
  type        = string
  default     = "lambda_function.lambda_handler"
}

variable "lambda_runtime" {
  description = "The runtime environment for the Lambda function."
  type        = string
  default     = "python3.8"
}

variable "lambda_role_name" {
  description = "The name of the IAM role for the Lambda function."
  type        = string
  default     = "lambda-exec-role"
}