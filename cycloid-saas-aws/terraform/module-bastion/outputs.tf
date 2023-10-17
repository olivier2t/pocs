#
# Bastion outputs
#
output "bastion_ip" {
  description = "The EIP attached to the bastion EC2 server"
  value       = try(aws_instance.bastion[0].public_ip, "")
}

output "vm_os_user" {
  description = "Admin username to connect to instance via SSH"
  value       = var.vm_os_user
}
