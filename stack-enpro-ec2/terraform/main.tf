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
    # demo = true
    # monitoring_discovery = false
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

  #. aws_vpc: 'vpc-0f4debf96b8a98c80'
  #+ VPC where to deploy the instance
  aws_vpc = "Value injected by StackForms"

  #. aws_subnet: 'subnet-0866446def6d05a3f'
  #+ Subnet where to deploy the instance
  aws_subnet = "Value injected by StackForms"

  #. aws_key: 'EnPro-SysOps-Lab'
  #+ Public Key to provision to the instance
  aws_key = "Value injected by StackForms"

  #. tag_name: ''
  #+ Tag for Instance name
  tag_name = "Value injected by StackForms"

  #. tag_division: ''
  #+ Tag for Division name
  tag_division = "Value injected by StackForms"

  #. tag_costcenter: ''
  #+ Tag for Cost Center name
  tag_costcenter = "Value injected by StackForms"

  #. tag_application: ''
  #+ Tag for Application name
  tag_application = "Value injected by StackForms"

  #. tag_application_owner: ''
  #+ Tag for Application owner
  tag_application_owner = "Value injected by StackForms"

  #. tag_backup: ''
  #+ Tag for Backup
  tag_backup = "Value injected by StackForms"

  #. tag_environment: ''
  #+ Tag for Environment
  tag_environment = "Value injected by StackForms"

}
