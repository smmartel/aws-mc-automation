terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws" # The source of the AWS provider
      version = "~> 5.0" # Specify the version of the AWS provider you want to use. Adjust as needed.
    }
  }
}

provider "aws" {
  region = "us-east-1" # My desired region for testing. You can change this as needed.
}