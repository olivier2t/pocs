#
# VPC outputs
#
output "vpc_id" {
  description = "The ID for the VPC"
  value       = module.cycloid-worker.vpc_id
}

#
# Instance outputs
#
output "vm_ip" {
  description = "The IP address the worker"
  value       = module.cycloid-worker.vm_ip
}