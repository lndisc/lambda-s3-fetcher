# lambda-s3-fetcher

This project creates an AWS Lambda function and an S3 bucket using Terraform.

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

## Which resources (websites/documentation) did you consult to develop the Infrastructure as Code solution using Terraform?

- [S3 Bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)
- [Lambda Function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function)

## What was the most significant challenge you encountered while working on this task?

The task itself wasn't challenging once you know the basics of AWS and Terraform. For me, the challenging part was creating the policies and roles with Terraform. I used to create IAM roles with the policy inside the resource via the jsonencode attribute. I wanted to follow Terraform's suggestion to use aws_iam_policy_document, so I had to review the documentation to do it.

Also I needed help for optimizing the python code with http code responses.

Other point to mention is that the inicial idea was to set the bucket name and file name to be fetched inside the python code. I externalized and passed during execution to have a lambda reusable.

## Were there any additional resources (either on Azure or AWS) required during the implementation? If so, please explain their necessity in the context of the solution.

IAM resources were essential for ensuring the security and proper functioning of our infrastructure on AWS. Specifically, they were required to manage permissions effectively, keeping the S3 Bucket private and granting necessary permissions to the Lambda function.

1. **IAM Role**: An IAM role was necessary to define the set of permissions that the Lambda function could assume when executing its tasks. This role acted as a set of policies and permissions that governed the actions the Lambda function could perform within AWS services.

2. **IAM Policy**: A custom IAM policy was created to specify the precise permissions needed by the Lambda function to interact with the S3 Bucket. This policy defined the actions that the Lambda function could take, such as reading the 'hello-world.txt' file from the S3 Bucket, while ensuring that it couldn't perform unauthorized actions.

3. **IAM Assume Role Policy**: This policy was crucial for granting the Lambda function permission to assume the IAM role created for it. It specified which entities (in this case, the Lambda function) were allowed to assume the role and under what conditions, ensuring that only authorized entities could access the resources associated with the role.

By configuring these IAM resources correctly, we were able to enforce least privilege principles, ensuring that our Lambda function had the necessary permissions to perform its tasks while minimizing the risk of unintended access or actions within our AWS environment.