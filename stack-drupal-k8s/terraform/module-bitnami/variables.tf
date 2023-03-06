# Cycloid
variable "customer" {}
variable "env" {}
variable "project" {}

#
# Kubernetes Cluster
#
variable "k8s_namespace" {
  description = "Namespace where to deploy the workload. The Namespace shall exist or be created beforehand."
  default = "default"
}

#
# Harbor Registry Database
#
variable "database_cluster" {
  description = "Database Cluster and Credentials"
}

variable "database_name" {
  description = "Database name"
}