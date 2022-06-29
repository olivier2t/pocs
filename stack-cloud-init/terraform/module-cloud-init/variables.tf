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
# Nexus Repository
#
variable "vm_instance_type" {
  description = "Instance type for the Nexus Repository"
  default     = "t3.micro"
}

variable "vm_os_user" {
  description = "Admin username to connect to instance via SSH. Set to 'admin' because we use debian OS."
  default     = "admin"
}

variable "vm_disk_size" {
  description = "Disk size for the Nexus Repository (Go)"
  default = "20"
}

variable "keypair_public" {
  description = "The public SSH key, for SSH access to newly-created instances"
}

# Teleport
variable "app_service_name" { default = "grafana" }
variable "token" { default = "" }
variable "target" { default = "localhost" }
variable "targetport" { default = 8000 }
variable "teleportserver" { default = "e98nco.teleport.sh" }
variable "teleportport" { default = 443 }

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