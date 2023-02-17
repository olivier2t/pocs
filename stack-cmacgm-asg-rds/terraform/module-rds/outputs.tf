#
# RDS instance outputs
#

output "rds_address" {
  description = "Address for the RDS instance"
  value       = aws_db_instance.rds.address
}

output "rds_port" {
  description = "Port for the RDS instance"
  value       = aws_db_instance.rds.port
}

output "rds_username" {
  description = "The database master username"
  value       = aws_db_instance.rds.username
}

# For demo purposes - Please remove for production use !!
output "rds_password" {
  description = "The database master password"
  value       = nonsensitive(random_password.password.result)
}

output "rds_db_name" {
  description = "Name for an automatically created database on cluster creation"
  value       = aws_db_instance.rds.db_name
}