# Cycloid
variable "customer" {}
variable "env" {}
variable "project" {}

# VPC
variable "vpc_id" {
  description = "The ID for the VPC"
}

variable "subnet_ids" {
  description = "The subnet IDs list where to deploy the Cycloid core servers."
}

variable "keypair_public" {
  description = "Used to connect on ES instance"
}

variable "trusted_cidr_blocks" {
  description = "A list of trusted external IP to allow connection from."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

# Cycloid Core
variable "core_instance_type" {
  description = "Instance type for the Cycloid Core servers"
  default     = "t3a.medium"
}

variable "core_instance_count" {
  description = "Instance count for the Cycloid Core servers"
  default     = 2
}

variable "core_volume_size" {
  description = "Volume size for the Cycloid Core servers root EBS volume."
  default     = 30
}

variable "core_volume_type" {
  description = "Volume type for the Cycloid Core servers root EBS volume."
  default     = "gp3"
}

variable "core_os_user" {
  description = "Admin username to connect to instance via SSH. Set to 'admin' because we use debian OS."
  default     = "admin"
}

variable "core_concourse_port" {
  description = "The Concourse port on which the Concourse workers connect to Cycloid backend."
  default     = 2222
}

# Domain
variable "core_hosted_zone" {
  description = "The domain name of the AWS hosted zone"
  default     = "eu.cycloid.io"
}

variable "core_domain_console" {
  description = "The Cycloid console subdomain of the hosted zone domain. This is used to access Cycloid console."
  default     = "console2"
}

variable "core_domain_api" {
  description = "The Cycloid API subdomain of the hosted zone domain. This is used to access Cycloid API."
  default     = "api2"
}

variable "core_domain_concourse" {
  description = "The Concourse subdomain of the hosted zone domain. This is used by the Concourse workers to connect to Cycloid backend."
  default     = "scheduler2"
}

variable "key_name" {
  description = "The SSH public key name to provision to EC2 servers"
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
