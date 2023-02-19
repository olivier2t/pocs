# Cycloid
variable "customer" {}
variable "env" {}
variable "project" {}

# VPC
variable "vpc_id" {
  description = "The ID for the VPC"
}

variable "vpc_azs" {
  description = "The Availability zones of the VPC"
}

variable "vpc_private_subnets" {
  description = "The private subnets list of the VPC"
}

variable "vpc_public_subnets" {
  description = "The public subnets list of the VPC"
}

# RDS
variable "rds_username" {
  description = "Username to connect to the RDS instance"
  default = "rds_user"
}

# ASG
variable "asg_ami_id" {
  description = "AMI ID for the ASG"
  default = "ami-089f338f3a2e69431"
}

variable "asg_instance_type" {
  description = "Instance types to use in the ASG"
  default = "t3a.small"
}

variable "asg_min_size" {
  description = "Minimum size for the ALB"
  default = 1
}

variable "asg_max_size" {
  description = "Maximum size for the ALB"
  default = 2
}

variable "asg_desired_capacity" {
  description = "Desired capacity for the ALB"
  default = 1
}

# Tags
variable "extra_tags" {
  default = {}
}

locals {
  standard_tags = {
    "cycloid" = "true"
    env          = var.env
    project      = var.project
    customer     = var.customer
  }
  merged_tags = merge(local.standard_tags, var.extra_tags)
}