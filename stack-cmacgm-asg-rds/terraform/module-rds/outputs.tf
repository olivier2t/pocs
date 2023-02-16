#
# RDS instance outputs
#

output "cluster_endpoint" {
  description = "Writer endpoint for the cluster"
  value       = module.rds.cluster_endpoint
}

output "cluster_master_username" {
  description = "The database master username"
  value       = module.rds.cluster_master_username
}

output "cluster_master_password" {
  description = "The database master password"
  value       = module.rds.cluster_master_password
}

output "cluster_database_name" {
  description = "Name for an automatically created database on cluster creation"
  value       = module.rds.cluster_database_name
}

output "cluster_arn" {
  description = "Amazon Resource Name (ARN) of cluster"
  value       = module.rds.cluster_arn
}