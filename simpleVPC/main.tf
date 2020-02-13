variable "vpc_cidr_block" {
  type = string
}
variable "subnet_cidr_block"{
    type = string
}
variable "vpcname" {
  type = string
}
variable "access_key" {
  type = string
}
variable "secret_access_key" {
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
  tags = {
    Name = "sentinelTest"
  }
}
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidr_block
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  depends_on              = ["aws_vpc.main"]
  tags = {
    Name = "sentinelTest"
  }
}
