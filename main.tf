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
  ingress = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks  = ["0.0.0.0/0"]
      description = "HTTP"
    },
  #  {
   #   from_port   = 443
    #  to_port     = 443
     # protocol    = "tcp"
      #cidr_blocks  = ["10.0.0.0/16"]
      #description = "HTTPS"
  #]
}