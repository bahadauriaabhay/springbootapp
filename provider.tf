terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.39.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket = "terraform-state321"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}