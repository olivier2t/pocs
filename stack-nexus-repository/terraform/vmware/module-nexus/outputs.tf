#
# VM outputs
#
output "vm_id" {
  description = "The UUID of the virtual machine"
  value       = vsphere_virtual_machine.nexus.id
}

output "vm_name" {
  description = "The name of this virtual machine"
  value       = vsphere_virtual_machine.nexus.name
}