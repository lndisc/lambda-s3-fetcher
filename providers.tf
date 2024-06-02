terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket         	   = "eg-dev-tf-lambda-s3-fetcher"
    key              	   = "state/terraform.tfstate"
    region         	   = "eu-west-1"
    encrypt        	   = true
    dynamodb_table = "eg-dev-tf-lambda-s3-fetcher-lock"
  }  
}

provider "aws" {
  region = var.aws_region
}