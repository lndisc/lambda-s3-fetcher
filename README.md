# lambda-s3-fetcher

This project creates an AWS Lambda function and an S3 bucket using Terraform.

## Resources and Documentation
You can find more information about the resources used in this project in the Terraform documentation:
- [S3 Bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)
- [Lambda Function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function)

## Requirements

- Terraform >= 0.14
- An AWS account with configured credentials

## Variables

- `aws_region`: The AWS region where resources will be created (default: `us-west-2`)
- `bucket_name`: The name of the S3 bucket
- `lambda_function_name`: The name of the Lambda function
- `lambda_handler`: The name of the Lambda handler function
- `lambda_runtime`: The runtime environment for the Lambda function
- `lambda_role_name`: The name of the IAM role for the Lambda function

## Usage

1. Clone this repository.
2. Set the required variables in `variables.tf`.
3. Run `terraform init` to initialize the Terraform project.
4. Run `terraform apply` to create the resources in your AWS account.
