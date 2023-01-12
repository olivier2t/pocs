#
# VPC outputs
#
output "vpc_id" {
  description = "The VPC ID for the VPC"
  value       = module.vpc.vpc_id
}

#
# RDS instance outputs
#
output "identifier" {
  description = "The VPC ID for the VPC"
  value       = "${var.customer}-${var.project}-${var.env}-rds"
}

output "username" {
  description = "The username of the RDS instance"
  value       = var.rds_username
}

output "password" {
  description = "The password of the RDS instance"
  value       = random_password.password.result
}