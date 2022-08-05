# Cycloid
variable "customer" {}
variable "env" {}
variable "project" {}

variable "rg_name" {
  type        = string
  description = "The name of the existing resource group where the resources will be deployed."
}

variable "mssql_servername" {
  type        = string
}

variable "mssql_administrator_login" {
  type        = string
}

variable "mssql_administrator_login_password" {
  type        = string
}

variable "mssql_database" {
  type        = string
}

# Tags
variable "extra_tags" {
  default = {}
}

locals {
  standard_tags = {
    "cycloid"    = "true"
    env          = var.env
    project      = var.project
    customer     = var.customer
  }
  merged_tags = merge(local.standard_tags, var.extra_tags)
}