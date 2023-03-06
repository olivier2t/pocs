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

  #. database_cluster: ""
  #+ Database Cluster and Credentials
  database_cluster = ""

  #. database_name: ""
  #+ Database name
  database_name = ""

}