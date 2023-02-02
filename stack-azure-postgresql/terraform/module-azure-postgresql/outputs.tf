#
# Resource Group outputs
#
output "rg_name" {
  description = "The name for the Resource Group"
  value       = data.azurerm_resource_group.webapp.name
}
