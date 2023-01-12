#
# VPC outputs
#
output "vpc_id" {
  description = "The VPC ID for the VPC"
  value       = module.rds.vpc_id
}

#
# RDS instance outputs
#
output "identifier" {
  description = "The VPC ID for the VPC"
  value       = module.rds.identifier
}

output "username" {
  description = "The username of the RDS instance"
  value       = module.rds.username
}

output "password" {
  description = "The password of the RDS instance"
  value       = module.rds.password
  sensitive   = true
}