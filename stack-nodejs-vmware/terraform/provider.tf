provider "vsphere" {
  user           = var.vsphere_cred.user
  password       = var.vsphere_cred.password
  vsphere_server = var.vsphere_cred.server

  # If you have a self-signed cert
  allow_unverified_ssl = var.vsphere_allow_unverified_ssl
}