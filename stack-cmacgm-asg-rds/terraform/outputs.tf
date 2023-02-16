#
# VPC outputs
#
output "vpc_id" {
  description = "The ID for the VPC"
  value       = module.network.vpc_id
}

output "vpc_name" {
  description = "The VPC name"
  value       = module.vpc_network.name
}

output "vpc_private_subnets" {
  description = "The private subnets list of the VPC"
  value       = module.network.vpc_private_subnets
}

output "vpc_public_subnets" {
  description = "The public subnets list of the VPC"
  value       = module.network.vpc_public_subnets
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