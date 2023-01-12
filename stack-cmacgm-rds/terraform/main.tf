module "rds" {
  #####################################
  # Do not modify the following lines #
  source   = "./module-rds"
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

  #. rds_instance_class: 'db.t3.micro'
  #+ RDS instance type
  rds_instance_class = "Value injected by StackForms"

  #. rds_allocated_storage: 5
  #+ Disk size for the RDS instance (Go)
  rds_allocated_storage = "Value injected by StackForms"

  #. rds_engine: 'postgres'
  #+ DB engine. Engine values include aurora, aurora-mysql, aurora-postgresql, docdb, mariadb, mysql, neptune, oracle-ee, oracle-se, oracle-se1, oracle-se2, postgres, sqlserver-ee, sqlserver-ex, sqlserver-se, and sqlserver-web.
  rds_engine = "Value injected by StackForms"

  #. rds_username: 'rds_user'
  #+ Username to connect to the RDS instance
  rds_username = "Value injected by StackForms"

}
