# Cycloid
variable "customer" {}
variable "env" {}
variable "project" {}

# NodeJS App
variable "git_app_url" {
  description = "Public git URL of the web application to build and deploy"
  default = ""
}

# Infra
variable "vm_instance_type" {
  description = "Instance type to deploy."
  default     = "t3a.small"
}

variable "vm_disk_size" {
  description = "Disk size for the instance (Go)"
  default = "20"
}

variable "vm_instance_ami" {
  description = "Instance AMI for the VM"
  default = "ami-02396cdd13e9a1257"
}

variable "aws_subnet" {
  description = "Subnet where to deploy the instance"
  default = "subnet-0866446def6d05a3f"
}

variable "tag_name" {
}

variable "tag_division" {
}

variable "tag_costcenter" {
}

variable "tag_application" {
}

variable "tag_application_owner" {
}

variable "tag_backup" {
}

variable "tag_environment" {
}

# Tags
variable "extra_tags" {
  default = {}
}

locals {
  standard_tags = {
    "cycloid" = "true"
    env              = var.env
    project          = var.project
    customer         = var.customer
    Name             = var.tag_name
    Division         = var.tag_division
    CostCenter       = var.tag_costcenter
    Application      = var.tag_application
    ApplicationOwner = var.tag_application_owner
    Backup           = var.tag_backup
    Environment      = var.tag_environment
  }
  merged_tags = merge(local.standard_tags, var.extra_tags)
}