module "ec2" {
  #####################################
  # Do not modify the following lines #
  source   = "git::https://github.com/olivier2t/iac-library.git"
  project  = var.project
  env      = var.env
  customer = var.customer
  #####################################

  #
  # Instance
  #

  #. vm_instance_type: 't3.micro'
  #+ Instance type for the VM
  vm_instance_type = "t3.micro"

  #. vm_disk_size: 20
  #+ Disk size for the VM (Go)
  vm_disk_size = "20"

}
