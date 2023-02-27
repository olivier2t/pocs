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

  #. database_cluster: ""
  #+ Database Cluster and Credentials
  database_cluster = ""

  #. database_coreDatabase: ""
  #+ Database coreDatabase name
  database_coreDatabase = ""

  #. database_notaryServerDatabase: ""
  #+ Database notaryServerDatabase name
  database_notaryServerDatabase = ""

  #. database_notarySignerDatabase: ""
  #+ Database notarySignerDatabase name
  database_notarySignerDatabase = ""

}