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
# Drupal
#
variable "database_endpoint" {
  description = "Database Endpoint"
}

variable "database_username" {
  description = "Database Username"
}

variable "database_password" {
  description = "Database Password"
}

variable "database_name" {
  description = "Database name"
}