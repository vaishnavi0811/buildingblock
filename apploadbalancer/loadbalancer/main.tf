variable "certARN" {
  type = string
}

data "aws_vpc" "getVPC" {
  filter {
    name   = "tag:Name"
    values = ["VPC501"]
  }
}
data "aws_subnet" "getSubnet" {
  vpc_id = data.aws_vpc.getVPC.id
}

resource "aws_lb" "MyAWSResource" {
  name                       = "sentinelELB"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = ["sg-001d4d1052759f3d5"]
  subnets                    = [data.aws_subnet.getSubnet.id]
  enable_deletion_protection = true
  enable_http2               = true
  tags = {
    Name        = "sentinelELB"
    Environment = "Development"
  }
}
resource "aws_lb_target_group" "albtargetgroup" {
  name     = "albfrontend"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = data.aws_vpc.getVPC.id
}
resource "aws_lb_listener" "frontend" {
  load_balancer_arn = aws_lb.MyAWSResource.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-FS-2018-06"
  certificate_arn   = var.certARN
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.albtargetgroup.arn
  }
}
