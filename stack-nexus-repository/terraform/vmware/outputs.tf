#
# VM outputs
#
output "vm_id" {
  description = "The UUID of the virtual machine"
  value       = module.nexus.vm_id
}

output "vm_name" {
  description = "The name of this virtual machine"
  value       = module.nexus.vm_name
}