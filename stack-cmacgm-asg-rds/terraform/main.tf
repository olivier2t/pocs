module "network" {
  #####################################
  # Do not modify the following lines #
  source   = "./module-network"
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
}

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

  #. vpc_id: []
  #+ The ID for the VPC
  vpc_id = module.network.vpc_id

  #. vpc_azs: []
  #+ The Availability zones of the VPC
  vpc_azs = module.network.vpc_azs

  #. vpc_private_subnets: []
  #+ The private subnets list of the VPC
  vpc_private_subnets = module.network.vpc_private_subnets

  #. vpc_public_subnets: []
  #+ The public subnets list of the VPC
  vpc_public_subnets = module.network.vpc_public_subnets

  #. rds_allocated_storage: 32
  #+ Disk size for the RDS cluster (Go)
  rds_allocated_storage = "Value injected by StackForms"

  #. rds_db_cluster_instance_class: 5
  #+ Instance class for the RDS cluster (Go)
  rds_db_cluster_instance_class = "Value injected by StackForms"

}
