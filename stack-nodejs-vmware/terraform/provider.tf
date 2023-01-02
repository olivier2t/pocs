provider "vsphere" {
  vsphere_server = var.vsphere_env["server"]
  user           = var.vsphere_env["user"]
  password       = var.vsphere_env["password"]

  # If you have a self-signed cert
  allow_unverified_ssl = var.vsphere_allow_unverified_ssl
}