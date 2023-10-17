# Cycloid
variable "customer" {}
variable "env" {}
variable "project" {}

variable "cycloid_sg_id" {
  description = "SG id of Cycloid instances."
}

variable "vpc_id" {}

variable "database_subnet_group_name" {
  description = "DB subnet."
}


# Common variables
variable "subnet_ids" {
  description = "List of subnets where to deploy RDS instances."
  type        = list(string)
}

variable "trusted_cidr_blocks" {
  description = "A list of trusted external IP to allow connection from."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

# Tags
variable "extra_tags" {
  default = {}
}

locals {
  standard_tags = {
    "cycloid" = "true"
    env       = var.env
    project   = var.project
    customer  = var.customer
  }
  merged_tags = merge(local.standard_tags, var.extra_tags)
}
