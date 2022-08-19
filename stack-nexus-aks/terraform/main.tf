module "nexus" {
  #####################################
  # Do not modify the following lines #
  source   = "./module-nexus"
  project  = var.project
  env      = var.env
  customer = var.customer
  #####################################

  #. extra_tags (optional): {}
  #+ Dict of extra tags to add on resources. format { "foo" = "bar" }.
  extra_tags = {
  }

  #. vm_disk_size: 20
  #+ Disk size for the Nexus Repository (Go)
  vm_disk_size = "20"

  #. nexus_port: 8081
  #+ Port where Nexus Repository service is exposed
  nexus_port = "8081"
}