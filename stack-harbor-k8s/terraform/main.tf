module "harbor" {
  #####################################
  # Do not modify the following lines #
  source   = "./module-harbor"
  project  = var.project
  env      = var.env
  customer = var.customer
  #####################################

  #. k8s_namespace: harbor
  #+ Namespace where to deploy the workload. The Namespace shall exist or be created beforehand.
  k8s_namespace = var.k8s_namespace

  #. database_host: ""
  #+ Database host
  database_host = ""

  #. database_port: ""
  #+ Database port
  database_port = ""

  #. database_username: ""
  #+ Database username
  database_username = ""

  #. database_password: ""
  #+ Database password
  database_password = ""

  #. database_coreDatabase: ""
  #+ Database coreDatabase name
  database_coreDatabase = ""

  #. notaryServerDatabase: ""
  #+ Database notaryServerDatabase name
  notaryServerDatabase = ""

  #. notarySignerDatabase: ""
  #+ Database notarySignerDatabase name
  notarySignerDatabase = ""

}