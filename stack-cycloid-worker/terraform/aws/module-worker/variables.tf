# Cycloid
variable "customer" {}
variable "env" {}
variable "project" {}

#
# VPC
#
variable "vpc_id" {
  type        = string
  description = "The ID of the VPC."
  default     = ""
}

#
# Instance
#
variable "vm_instance_type" {
  description = "Instance type for the Cycloid worker"
  default     = "t3.micro"
}

variable "vm_disk_size" {
  description = "Disk size for the Cycloid worker (Go)"
  default = "20"
}

variable "keypair_public" {
  description = "The public SSH key, for SSH access to newly-created instances"
}

variable "vm_os_user" {
  description = "Admin username to connect to instance via SSH. Set to 'admin' because we use debian OS."
  default     = "admin"
}

#
# Cycloid worker
#
variable "team_id" {
  description = "Cycloid team ID"
  default     = ""
}

variable "worker_key" {
  description = "Cycloid worker key"
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