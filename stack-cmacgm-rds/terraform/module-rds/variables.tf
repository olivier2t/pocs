# Cycloid
variable "customer" {}
variable "env" {}
variable "project" {}

# RDS
variable "rds_instance_class" {
  description = "RDS instance type."
  default     = "db.t3.micro"
}

variable "rds_allocated_storage" {
  description = "Disk size for the RDS instance (Go)"
  default = "5"
}

variable "rds_engine" {
  description = "DB engine. Engine values include aurora, aurora-mysql, aurora-postgresql, docdb, mariadb, mysql, neptune, oracle-ee, oracle-se, oracle-se1, oracle-se2, postgres, sqlserver-ee, sqlserver-ex, sqlserver-se, and sqlserver-web."
  default     = "postgres"
}

variable "rds_username" {
  description = "Username to connect to the RDS instance"
  default = "rds_user"
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