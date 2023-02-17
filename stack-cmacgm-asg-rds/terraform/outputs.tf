#
# VPC outputs
#
output "vpc_id" {
  description = "The ID for the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_name" {
  description = "The VPC name"
  value       = module.vpc.name
}

output "vpc_private_subnets" {
  description = "The private subnets list of the VPC"
  value       = module.vpc.vpc_private_subnets
}

output "vpc_public_subnets" {
  description = "The public subnets list of the VPC"
  value       = module.vpc.vpc_public_subnets
}

#
# RDS instance outputs
#
output "rds_address" {
  description = "Address for the RDS instance"
  value       = module.rds.rds_address
}

output "rds_port" {
  description = "Port for the RDS instance"
  value       = module.rds.rds_port
}

output "rds_username" {
  description = "The database master username"
  value       = module.rds.rds_username
}

# For demo purposes - Please remove for production use !!
output "rds_password" {
  description = "The database master password"
  value       = module.rds.rds_password
}

output "rds_db_name" {
  description = "Name for an automatically created database on cluster creation"
  value       = module.rds.rds_db_name
}