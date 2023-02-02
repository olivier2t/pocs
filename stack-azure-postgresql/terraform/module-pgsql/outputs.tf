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
output "fqdn" {
  description = "The PostgreSQL Server FQDN"
  value       = azurerm_postgresql_server.pgsql.fqdn
}

output "administrator_login" {
  description = "The Administrator login for the PostgreSQL Server"
  value       = azurerm_postgresql_server.pgsql.administrator_login
}

output "administrator_password" {
  description = "The Administrator password for the PostgreSQL Server"
  value       = nonsensitive(random_password.password.result)
}