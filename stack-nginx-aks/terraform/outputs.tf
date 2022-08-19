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

output "lb_ip" {
  description = "Azure ingress IP address to access the service"
  value       = module.nginx.lb_ip
}