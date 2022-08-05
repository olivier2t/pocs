#
# Outputs
#
output "rg_name" {
  description = "The name for the Resource Group"
  value       = module.mssql.rg_name
}