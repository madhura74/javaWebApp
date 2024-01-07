
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.15.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.1"
    }
  }


  backend "s3" {
    bucket  = "mads301"
    key     = "my-terraform-project"
    region  = "ap-south-1"
    profile = "terraform"
  }

}


provider "aws" {
  # Configuration options
  profile = "terraform"
  region  = "ap-south-1"

}

resource "random_string" "suffix" {
  length  = 5
  special = false
}