#
# Resource Group outputs
#
output "rg_name" {
  description = "The name for the Resource Group"
  value       = module.pgsql.rg_name
}

#
# PostgreSQL outputs
#
output "administrator_login" {
  description = "The Administrator login for the PostgreSQL Server"
  value       = module.pgsql.administrator_login
}

output "administrator_password" {
  description = "The Administrator password for the PostgreSQL Server"
  value       = module.pgsql.administrator_password
}