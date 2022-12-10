# Cycloid
variable "customer" {}
variable "env" {}
variable "project" {}

#
# Kubernetes Cluster
#
variable "eks_cluster_name" {
  description = "Cluster name where to deploy the workload. The Kubernetes cluster shall exist or be created beforehand."
  default = "default"
}

variable "eks_namespace" {
  description = "Namespace where to deploy the workload. The Namespace shall exist or be created beforehand."
  default = "default"
}

#
# Nexus Repository
#
variable "vm_disk_size" {
  description = "Disk size for the Nexus Repository (Go)"
  default = "10"
}

variable "nexus_port" {
  description = "Port where Nexus Repository service is exposed"
  default = "8081"
}