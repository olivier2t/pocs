#
# Resource Group outputs
#
output "rg_name" {
  description = "The name for the Resource Group"
  value       = module.webapp.rg_name
}