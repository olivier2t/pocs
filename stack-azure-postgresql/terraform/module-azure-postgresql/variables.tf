# Cycloid
variable "customer" {}
variable "env" {}
variable "project" {}

# Azure PostgreSQL
variable "administrator_login" {
  description = "The Administrator login for the PostgreSQL Server"
  default     = "psqladmin"
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