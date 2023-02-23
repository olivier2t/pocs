# Cycloid variables
variable "env" {}
variable "project" {}
variable "customer" {}

# AWS variables
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {
  description = "AWS region where to create servers."
  default     = "eu-west-1"
}

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