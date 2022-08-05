#
# Resource Group outputs
#
output "rg_name" {
  description = "The name for the resource group"
  value       = data.azurerm_resource_group.asmodee.name
}