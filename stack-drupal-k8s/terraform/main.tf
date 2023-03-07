module "bitnami" {
  #####################################
  # Do not modify the following lines #
  source   = "./module-bitnami"
  project  = var.project
  env      = var.env
  customer = var.customer
  #####################################

  #. k8s_namespace: drupal
  #+ Namespace where to deploy the workload. The Namespace shall exist or be created beforehand.
  k8s_namespace = var.k8s_namespace

  #. database_endpoint: ""
  #+ Database Endpoint
  database_endpoint = var.database_endpoint

  #. database_username: ""
  #+ Database Username
  database_username = var.database_username

  #. database_password ""
  #+ Database Password
  database_password = var.database_password

  #. database_name: ""
  #+ Database name
  database_name = var.database_name

}