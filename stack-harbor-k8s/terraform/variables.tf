# Cycloid variables
variable "env" {}
variable "project" {}
variable "customer" {}

#
# Kubernetes
#
variable k8s_host {
  type        = string
  description = "The hostname (in form of URI) of the Kubernetes API."
  default     = ""
}

variable k8s_cluster_ca_certificate {
  type        = string
  description = "PEM-encoded root certificates bundle for TLS authentication."
  default     = ""
}

variable k8s_token {
  type        = string
  description = "Token of your service account."
  default     = ""
}

variable "k8s_namespace" {
  description = "Namespace where to deploy the workload. The Namespace shall already exist."
  default = ""
}