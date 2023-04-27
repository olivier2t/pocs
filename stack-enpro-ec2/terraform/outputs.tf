#
# Instance outputs
#
output "url" {
  description = "The URL of the wepapp"
  value       = "http://${module.ec2.vm_ip}"
}