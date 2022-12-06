module "webapp" {
  #####################################
  # Do not modify the following lines #
  source   = "./module-webapp"
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
  # AWS Account
  #

  #. access_key: ''
  #+ AWS Access Key
  access_key = "Value injected by StackForms"

  #. secret_key: ''
  #+ AWS Secret Key
  secret_key = "Value injected by StackForms"

  #. region: ''
  #+ AWS Region
  region = "Value injected by StackForms"

  #
  # Web App
  #

  #. git_app_url: ''
  #+ Public git URL of the web application to build and deploy
  git_app_url = "Value injected by StackForms"

  #
  # Instance
  #

  #. vm_instance_type: 't3.micro'
  #+ Instance type for the Nexus Repository
  vm_instance_type = "Value injected by StackForms"

  #. vm_disk_size: 20
  #+ Disk size for the Nexus Repository (Go)
  vm_disk_size = "Value injected by StackForms"

  #. keypair_public: ''
  #+ Public key to provision to the instance
  keypair_public = "Value injected by StackForms"

}
