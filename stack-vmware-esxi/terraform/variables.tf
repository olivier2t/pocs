# Cycloid variables
variable "env" {}
variable "project" {}
variable "customer" {}

# ESXi variables
variable "esxi_user" {}
variable "esxi_password" {}
variable "esxi_server" {}

variable "esxi_allow_unverified_ssl"{
    default = true
}