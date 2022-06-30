provider "vsphere" {
  user           = var.esxi_user
  password       = var.esxi_password
  vsphere_server = var.esxi_server

  # If you have a self-signed cert
  allow_unverified_ssl = var.esxi_allow_unverified_ssl
}