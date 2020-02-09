variable "vpc_cidr_block"{
    type = string
}
variable "vpcname"{
    type = string
}
resource "aws_vpc" "main" {
    cidr_block           = var.vpc_cidr_block
    enable_dns_hostnames = true
    enable_dns_support   = true
    instance_tenancy     = "default"
    tags  {
      Name = var.vpcname
    }
}