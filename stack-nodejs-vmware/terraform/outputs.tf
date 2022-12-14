#
# VM outputs
#
output "vm_id" {
  description = "The UUID of the virtual machine"
  value       = module.webapp.vm_id
}

output "vm_name" {
  description = "The name of this virtual machine"
  value       = module.webapp.vm_name
}

output "vm_ssh" {
  description = "The SSH address to connect to the instance"
  value       = "${module.webapp.vm_os_user}@${module.webapp.vm_ip}"
}

output "url" {
  description = "The URL of the wepapp"
  value       = "http://${module.webapp.vm_ip}"
}