#
# RDS instance outputs
#
output "rds_endpoint" {
  description = "Endpoint for the RDS instance"
  value       = module.rds.rds_endpoint
}

# output "rds_address" {
#   description = "Address for the RDS instance"
#   value       = module.rds.rds_address
# }

# output "rds_port" {
#   description = "Port for the RDS instance"
#   value       = module.rds.rds_port
# }

output "rds_db_name" {
  description = "Name for an automatically created database on cluster creation"
  value       = module.rds.rds_db_name
}

output "rds_username" {
  description = "The database master username"
  value       = module.rds.rds_username
}

output "rds_password" {
  description = "The database master password"
  value       = module.rds.rds_password
  sensitive   = true
}

