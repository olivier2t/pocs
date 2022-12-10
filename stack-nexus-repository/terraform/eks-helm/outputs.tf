#
# Nexus Repository outputs
#
output "nexus_port" {
  description = "Port where Nexus Repository service is exposed"
  value       = module.nexus.nexus_port
}

output "eks_cluster_name" {
  description = "Cluster name where to deploy the workload"
  value       = var.eks_cluster_name
}

output "eks_namespace" {
  description = "Namespace where to deploy the workload"
  value       = var.eks_namespace
}

output "eks_endpoint" {
  description = "Cluster endpoint where to deploy the workload."
  value       = data.aws_eks_cluster.default.endpoint
}