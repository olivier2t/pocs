module "harbor" {
  #####################################
  # Do not modify the following lines #
  source   = "./module-harbor"
  project  = var.project
  env      = var.env
  customer = var.customer
  #####################################

  #. eks_namespace: harbor
  #+ Namespace where to deploy the workload. The Namespace shall exist or be created beforehand.
  eks_namespace = var.eks_namespace

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

  #. database_core_name: ""
  #+ Database core name
  database_core_name = ""

}