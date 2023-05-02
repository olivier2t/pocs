#
# VPC outputs
#
output "vpc_id" {
  description = "The VPC ID for the VPC"
  value       = module.cloud-init.vpc_id
}

#
# Nexus Repository outputs
#
output "vm_ip" {
  description = "The IP address the Nexus Repository server"
  value       = module.cloud-init.vm_ip
}

output "vm_os_user" {
  description = "The username to use to connect to the Nexus Repository instance via SSH."
  value       = module.cloud-init.vm_os_user
}

