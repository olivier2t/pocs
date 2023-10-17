# Cycloid variables
variable "env" {}

variable "project" {}
variable "customer" {}

# AWS variables
variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "aws_region" {
  description = "AWS region where to create servers."
  default     = "eu-west-1"
}

variable "keypair_public" {}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

locals {
  private_subnets  = [for k, v in slice(data.aws_availability_zones.available.names, 0, 2) : cidrsubnet(var.vpc_cidr, 8, k)]
  public_subnets   = [for k, v in slice(data.aws_availability_zones.available.names, 0, 2) : cidrsubnet(var.vpc_cidr, 8, k + 10)]
  database_subnets = [for k, v in slice(data.aws_availability_zones.available.names, 0, 2) : cidrsubnet(var.vpc_cidr, 8, k + 20)]
}
