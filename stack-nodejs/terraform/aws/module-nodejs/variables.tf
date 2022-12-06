# Cycloid
variable "customer" {}
variable "env" {}
variable "project" {}

# AWS Account
variable "access_key" {
  description = "AWS Access Key"
  default     = ""
}

variable "secret_key" {
  description = "AWS Secret Key"
  default     = ""
}

variable "access_key" {
  description = "AWS Access Key"
  default     = ""
}

variable "region" {
  description = "AWS Region"
  default     = ""
}

# Infra
variable "vm_os_user" {
  description = "Admin username to connect to instance via SSH. Set to 'admin' because we use debian OS."
  default     = "admin"
}

variable "vm_disk_size" {
  description = "Disk size for the Nexus Repository (Go)"
  default = "20"
}

variable "keypair_public" {
  description = "Public key to provision to the instance"
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