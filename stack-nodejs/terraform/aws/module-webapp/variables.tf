# Cycloid
variable "customer" {}
variable "env" {}
variable "project" {}

# AWS Account
variable "aws_access_key" {
  description = "AWS Access Key"
  default     = ""
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  default     = ""
}

variable "aws_region" {
  description = "AWS Region"
  default     = ""
}

# Infra
variable "vm_instance_type" {
  description = "Instance type to deploy."
  default     = "t3a.small"
}

variable "vm_os_user" {
  description = "Admin username to connect to instance via SSH. Set to 'admin' because we use debian OS."
  default     = "admin"
}

variable "vm_disk_size" {
  description = "Disk size for the instance (Go)"
  default = "20"
}

variable "keypair_public" {
  description = "Public key to provision to the instance"
  default = ""
}

# NodeJS App
variable "git_app_url" {
  description = "Public git URL of the web application to build and deploy"
  default = ""
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