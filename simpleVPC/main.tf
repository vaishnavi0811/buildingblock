variable "vpc_cidr_block"{
    type = string
}
variable "vpcname"{
    type = string
}
variable "access_key"{
    type = string
}
variable "secret_access_key"{
    type = string
}
provider "aws" {
  region     = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_access_key
}
resource "aws_vpc" "main" {
    cidr_block           = var.vpc_cidr_block
    enable_dns_hostnames = true
    enable_dns_support   = true
    instance_tenancy     = "default"
    tags  = {
      Name = var.vpcname
    }
}