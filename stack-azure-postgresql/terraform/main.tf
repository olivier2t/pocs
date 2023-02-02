module "pgsql" {
  #####################################
  # Do not modify the following lines #
  source   = "./module-pgsql"
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

  #. azure_location: "West Europe"
  #+ Azure location
  azure_location = "Value injected by StackForms"

  #. rg_name: ''
  #+ The name of the existing resource group where the resources will be deployed
  rg_name = "Value injected by StackForms"

  #. administrator_login: 'psqladmin'
  #+ The Administrator login for the PostgreSQL Server
  administrator_login = "Value injected by StackForms"

}
