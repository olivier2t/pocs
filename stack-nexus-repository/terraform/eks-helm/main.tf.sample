module "nexus" {
  #####################################
  # Do not modify the following lines #
  source   = "./module-nexus"
  project  = var.project
  env      = var.env
  customer = var.customer
  #####################################

  #. eks_cluster_name: default
  #+ Cluster name where to deploy the workload. The Kubernetes cluster shall exist or be created beforehand.
  eks_cluster_name = var.eks_cluster_name

  #. eks_namespace: nexus
  #+ Namespace where to deploy the workload. The Namespace shall exist or be created beforehand.
  eks_namespace = var.eks_namespace

  #. vm_disk_size: 20
  #+ Disk size for the Nexus Repository (Go)
  vm_disk_size = 20

  #. nexus_port: 8081
  #+ Port where Nexus Repository service is exposed
  nexus_port = 8081
}