# Cycloid variables
variable "env" {}
variable "project" {}
variable "customer" {}

# vSphere variables
variable "vsphere_env" {}
variable "vsphere_allow_unverified_ssl"{
    default = true
}