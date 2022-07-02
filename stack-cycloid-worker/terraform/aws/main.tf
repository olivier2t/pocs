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
  vm_instance_type = "t3.micro"

  #. vm_disk_size: 20
  #+ Disk size for the Cycloid worker (Go)
  vm_disk_size = "20"

  #. keypair_public: ""
  #+ The public SSH key, for SSH access to newly-created instances
  keypair_public = var.keypair_public


  #
  # Cycloid worker
  #

  #. team_id: ""
  #+ This parameter can be obtained in Cycloid console, by clicking on your profile picture at the top right corner, then organization settings, then use the value of the ci_team_member field.
  team_id = "<YOUR_TEAM_ID>"

  #. worker_key: ""
  #+ This parameter can be obtained in Cycloid console, by clicking on security/credentials section on the left menu, then look for of a credential named Cycloid-worker-keys, then use the value of the ssh_prv field.
  worker_key = "<YOUR_WORKER_KEY>"
}