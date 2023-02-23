# Cycloid
variable "customer" {}
variable "env" {}
variable "project" {}

#
# Kubernetes Cluster
#
variable "eks_namespace" {
  description = "Namespace where to deploy the workload. The Namespace shall exist or be created beforehand."
  default = "default"
}

#
# Harbor Registry Database
#
variable "database_host" {
  description = "Database host"
}

variable "database_port" {
  description = "Database port"
}

variable "database_username" {
  description = "Database username"
}

variable "database_password" {
  description = "Database password"
}

variable "database_core_name" {
  description = "Database core name"
}