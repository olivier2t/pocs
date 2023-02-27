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

variable "database_coreDatabase" {
  description = "Database coreDatabase name"
}

variable "database_notaryServerDatabase" {
  description = "Database notaryServerDatabase name"
}

variable "database_notarySignerDatabase" {
  description = "Database notarySignerDatabase name"
}