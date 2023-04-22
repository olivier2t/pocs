module "ec2" {
  #####################################
  # Do not modify the following lines #
  source   = "github.com/olivier2t/iac-library"
  project  = var.project
  env      = var.env
  customer = var.customer
  #####################################

  #. extra_tags (optional): {}
  #+ Dict of extra tags to add on resources. format { "foo" = "bar" }.
  extra_tags = {
    demo = true
    monitoring_discovery = false
  }

  #
  # Instance
  #

  #. vm_instance_type: 't3.micro'
  #+ Instance type for the VM
  vm_instance_type = 't3.micro'

  #. vm_disk_size: 20
  #+ Disk size for the VM (Go)
  vm_disk_size = 20

  #. keypair_public: ''
  #+ Public key to provision to the instance
  keypair_public = var.keypair_public

}
