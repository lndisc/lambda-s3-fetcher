# lambda-s3-fetcher

This project creates an AWS Lambda function and an S3 bucket using Terraform.

## Resources and documentation
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function

## Requirements

- Terraform >= 0.14
- An AWS account and configured credentials

## Variables

- `aws_region`: The AWS region where resources will be created (default: `us-west-2`)
- `bucket_name`: The name of the S3 bucket
- `lambda_name`: The name of the Lambda function

## Usage

1. Clone the repository.
2. Set the necessary variables in `variables.tf`.
3. Run `terraform init` to initialize the project.
4. Run `terraform apply` to create the resources.