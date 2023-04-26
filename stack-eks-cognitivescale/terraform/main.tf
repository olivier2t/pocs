module "eks" {
  #####################################
  # Do not modify the following lines #
  source   = "./module-eks"
  # project  = var.project
  # env      = var.env
  # customer = var.customer
  #####################################

  #. extra_tags (optional): {}
  #+ Dict of extra tags to add on resources. format { "foo" = "bar" }.
  # extra_tags = {
  #   demo = true
  #   monitoring_discovery = false
  # }

  #
  # EKS cluster
  #

  #. cluster_name: 'certifai-125-eks-dev'
  #+ EKS Cluster name
  cluster_name = "Value injected by StackForms"

  #. cluster_version: "1.25"
  #+ EKS Cluster version
  cluster_version = "Value injected by StackForms"

}
