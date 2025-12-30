terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  # assume_role {
  #   role_arn = "arn:aws:iam::${var.accountId}:role/${var.assume_role_name}"
  #   session_name = "tf"
  # }
}


