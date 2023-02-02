#
# Resource Group outputs
#
output "rg_name" {
  description = "The name for the Resource Group"
  value       = data.azurerm_resource_group.rg.name
}

#
# PostgreSQL outputs
#
output "administrator_login" {
  description = "The Administrator login for the PostgreSQL Server"
  value       = azurerm_postgresql_server.pgsql.administrator_login
}

output "administrator_password" {
  description = "The Administrator password for the PostgreSQL Server"
  value       = random_password.password.result
}