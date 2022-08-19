#
# AKS outputs
#
output "aks_cluster_name" {
  description = "The name of the AKS cluster"
  value       = var.aks_cluster_name
}

output "aks_resource_group_name" {
  description = "The name of the resource group where the AKS cluster resides"
  value       = var.aks_resource_group_name
}

#
# Nexus Repository outputs
#
output "nexus_port" {
  description = "Port where Nexus Repository service is exposed"
  value = module.nexus.nexus_port
}