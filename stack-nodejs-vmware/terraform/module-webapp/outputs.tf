#
# VM outputs
#
output "vm_id" {
  description = "The UUID of the virtual machine"
  value       = vsphere_virtual_machine.vm.id
}

output "vm_name" {
  description = "The name of this virtual machine"
  value       = vsphere_virtual_machine.vm.name
}