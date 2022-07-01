module "cycloid-worker" {
  #####################################
  # Do not modify the following lines #
  source = "./module-cycloid-worker"

  project  = var.project
  env      = var.env
  customer = var.customer
  #####################################

  #. extra_tags (optional): {}
  #+ Dict of extra tags to add on resources. format { "foo" = "bar" }.
  extra_tags = {
    demo                 = true
    monitoring_discovery = false
  }

  #
  # Instance
  #

  #. vm_instance_type: 't3.micro'
  #+ Instance type for the Cycloid worker
  vm_instance_type = "Value injected by StackForms"

  #. vm_disk_size: 20
  #+ Disk size for the Cycloid worker (Go)
  vm_disk_size = "Value injected by StackForms"

  #. keypair_public: ""
  #+ The public SSH key, for SSH access to newly-created instances
  keypair_public = var.keypair_public


  #
  # Cycloid worker
  #

  #. team_id: ""
  #+ Cycloid team ID
  team_id = "Value injected by StackForms"

  #. worker_key: ""
  #+ Cycloid worker key
  worker_key = "Value injected by StackForms"
}