module "azure-postgresql" {
  #####################################
  # Do not modify the following lines #
  source   = "./module-azure-postgresql"
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

  #. administrator_login: 'psqladmin'
  #+ The Administrator login for the PostgreSQL Server
  administrator_login = "Value injected by StackForms"

}
