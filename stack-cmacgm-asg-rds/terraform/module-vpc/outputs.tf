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

output "vpc_azs" {
  description = "The Availability zones of the VPC"
  value       = module.vpc.azs
}

output "vpc_private_subnets" {
  description = "The private subnets list of the VPC"
  value       = module.vpc.private_subnets
}

output "vpc_public_subnets" {
  description = "The public subnets list of the VPC"
  value       = module.vpc.public_subnets
}