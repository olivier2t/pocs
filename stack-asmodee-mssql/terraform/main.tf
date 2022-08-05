module "mssql" {
  #####################################
  # Do not modify the following lines #
  source   = "./module-mssql"
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

  #. rg_name: 'cycloid-get-started'
  #+ The name of the existing resource group where the resources will be deployed
  rg_name = "Value injected by StackForms"
  mssql_servername = "Value injected by StackForms"
  mssql_administrator_login = "Value injected by StackForms"
  mssql_administrator_login_password = "Value injected by StackForms"
  mssql_database = "Value injected by StackForms"
}