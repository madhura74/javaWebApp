terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.31.0"
    }
  }

  backend "s3" {
    
  }

}

locals {
 ecr_name  = "madecr01"
 }



provider "aws" {
  # Configuration options
}

resource "aws_ecr_repository" "ecr_1" {
  name                 = local.ecr_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
