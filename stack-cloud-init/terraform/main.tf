module "cloud-init" {
  #####################################
  # Do not modify the following lines #
  source   = "./module-cloud-init"
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
  # VPC
  #

  #. vpc_id: ''
  #+ The ID of the VPC
  vpc_id = "Value injected by StackForms"

  #
  # Instance
  #

  #. vm_instance_type: 't3.micro'
  #+ Instance type for the Nexus Repository
  vm_instance_type = "Value injected by StackForms"

  #. vm_disk_size: 20
  #+ Disk size for the Nexus Repository (Go)
  vm_disk_size = "Value injected by StackForms"

  #. keypair_public: ""
  #+ The public SSH key, for SSH access to newly-created instances
  keypair_public = var.keypair_public

  #
  # Teleport
  #

  #. app_service_name: 'grafana'
  #+ Teleport app service name
  app_service_name = "Value injected by StackForms"

  #. token: ''
  #+ Teleport token
  token = "Value injected by StackForms"

  #. target: 'localhost'
  #+ Teleport target hostname
  target = "Value injected by StackForms"

  #. targetport: '8000'
  #+ Teleport target port
  targetport = "Value injected by StackForms"

  #. teleportserver: 'e98nco.teleport.sh'
  #+ Teleport server hostname
  teleportserver = "Value injected by StackForms"

  #. teleportport: '443'
  #+ Teleport server port
  teleportport = "Value injected by StackForms"
}
