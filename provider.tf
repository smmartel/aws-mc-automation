terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws" # The source of the AWS provider
      version = "~> 5.0" # Specify the version of the AWS provider you want to use. Adjust as needed.
    }
  }
}

provider "aws" {
  region = "us-east-1" # Specify your desired AWS region change in the python script as well
}