module "ec2" {
  #####################################
  # Do not modify the following lines #
  source   = "./module-ec2"
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
  vm_instance_type = "Value injected by StackForms"

  #. vm_disk_size: 20
  #+ Disk size for the VM (Go)
  vm_disk_size = "Value injected by StackForms"

  #. vm_instance_ami: 'ami-02396cdd13e9a1257'
  #+ Instance AMI for the VM
  vm_instance_ami = "Value injected by StackForms"

}
