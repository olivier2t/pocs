# Cycloid
variable "customer" {}
variable "env" {}
variable "project" {}

variable "organization_name" {
  description = "The name of the Cycloid organization."
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