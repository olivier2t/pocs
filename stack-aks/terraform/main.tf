
# By default this stack will create a dedicated network for the AKS Cluster
# as the default pod networking will be using this VPC.
#
module "vpc" {
  #####################################
  # Do not modify the following lines #
  source = "./module-vpc"

  project  = var.project
  env      = var.env
  customer = var.customer
  #####################################

  #. address_space (optional): 10.8.0.0/16
  #+ The virtual network address space.
  address_space = "10.8.0.0/14"

  #. subnets (optional, list): {"nodes" = "10.8.0.0/16", "pods"  = "10.9.0.0/16", "loadbalancers" = "10.11.0.0/16",}
  #+ The private subnets for the VPC.
  subnets = {
    "nodes" = "10.8.0.0/16",
    "pods"  = "10.9.0.0/16",
    # Azure don't like Terraform to create the service subnet used by AKS so we should skip it
    # "services" = "10.10.0.0/16",
    "loadbalancers" = "10.11.0.0/16",
  }

  #. resource_group_name (optional): "cycloid-aks"
  #+ Existing Azure Resource Group where to deploy the new infrastructure.
  resource_group_name = var.resource_group_name

}

module "aks" {
  #####################################
  # Do not modify the following lines #
  source = "./module-aks"

  project  = var.project
  env      = var.env
  customer = var.customer
  #####################################

  #. network_pod_cidr (optional): 10.9.0.0/16
  #+ AKS cluster pod CIDR to use, required if `network_plugin = kubenet`.
  network_pod_cidr = "10.9.0.0/16"

  #. network_service_cidr (optional): 10.10.0.0/16
  #+ AKS cluster service CIDR to use, required if `network_plugin = azure`.
  network_service_cidr = "10.10.0.0/16"

  ###
  # Default Nodes Pool
  ###

  #. node_pool_name (optional): default
  #+ AKS default nodes pool given name.
  node_pool_name = "default"

  #. node_network_subnet_id (required):
  #+ Network subnet ID that should be used by AKS default nodes.
  node_network_subnet_id = module.vpc.vnet_subnet_ids["nodes"]

  #. node_size (optional): Standard_DS2_v2
  #+ AKS default nodes virtualmachine size.
  node_size = "Standard_DS2_v2"

  #. node_count (optional): 1
  #+ AKS default nodes desired count.
  node_count = "1"

  #. resource_group_name (optional): "cycloid-aks"
  #+ Existing Azure Resource Group where to deploy the new infrastructure.
  resource_group_name = var.resource_group_name

  cluster_name                    = "${var.customer}-${var.project}-${var.env}-aks"
  service_principal_client_id     = var.aks_service_principal_client_id
  service_principal_client_secret = var.aks_service_principal_client_secret

}