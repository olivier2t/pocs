# Cycloid
variable "customer" {}
variable "project" {}
variable "env" {}

#
# NGINX
#
variable "nginx_version" {
  description = "Version of NGINX to deploy"
  default = "1.7.8"
}

variable "nginx_port" {
  description = "Port where NGINX service is exposed"
  default = "80"
}

variable "nginx_cpu_limit" {
  description = "CPU resource limit for the deployment"
  default = "0.5"
}

variable "nginx_mem_limit" {
  description = "Memory resource limit for the deployment"
  default = "512Mi"
}

variable "nginx_cpu_request" {
  description = "CPU resource request for the deployment"
  default = "250m"
}

variable "nginx_mem_request" {
  description = "Memory resource request for the deployment"
  default = "50Mi"
}

variable "aks_cluster_name" {
  description = "AKS cluster name"
  default = ""
}

variable "resource_group_name" {
  description = "Resource group name to use to deploy the network security group"
  default = "cycloid-aks"
}