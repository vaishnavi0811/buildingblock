variable "access_key" {
  type = string
}
variable "secret_access_key" {
  type = string
}
variable "region" {
  type = string
}
variable "domainName" {
  type = string
}
variable "organization" {
  type = string
}
variable "algorithm" {
  type = string
}
provider "aws" {
   access_key = var.access_key
   secret_key = var.secret_access_key
   region = var.region
}
module "cert" {
  source = "./cert"
  domainName = var.domainName
  organization = var.organization
  algorithm = var.algorithm
}
module "aag" {
  source = "./loadbalancer"
  certARN = module.cer.certARN
}
