terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "029DA-DevOps24"
    
    workspaces {
        prefix = "network-"
    }
  }
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~>5.0"
    }
  }
}

provider "aws" {}


resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
} 

module "security-groups" {
  source  = "app.terraform.io/029DA-DevOps24/security-groups/aws"
  version = "1.0.0"
  vpc_id = aws_vpc.main.id# insert required variables here
}