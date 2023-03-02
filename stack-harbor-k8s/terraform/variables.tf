# Cycloid variables
variable "env" {}
variable "project" {}
variable "customer" {}

#
# Kubernetes
#
variable k8s_cluster {
  type = object({
    host                    = string
    cluster_ca_certificate  = string
    token                   = string 
  })
  description = "Kubernetes Cluster and Credentials. Includes host, cluster_ca_certificate and token."
  default     = ""
}

variable "k8s_namespace" {
  description = "Namespace where to deploy the workload. The Namespace shall already exist."
  default = ""
}