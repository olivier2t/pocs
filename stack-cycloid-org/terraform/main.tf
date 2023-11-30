module "cycloid-org" {
  #####################################
  # Do not modify the following lines #
  source   = "./module-cycloid-org"
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
  # Cycloid Organization
  #

  #. organization_name: ''
  #+ The name of the Cycloid organization
  organization_name = "Value injected by StackForms"

}
