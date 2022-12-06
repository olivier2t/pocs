#
# VPC outputs
#
output "vpc_id" {
  description = "The VPC ID for the VPC"
  value       = module.webapp.vpc_id
}

#
# Instance outputs
#
output "vm_ip" {
  description = "The IP address of the instance"
  value       = module.webapp.vm_ip
}

output "vm_os_user" {
  description = "The username to use to connect to the instance via SSH."
  value       = module.webapp.vm_os_user
}

