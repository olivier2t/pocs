#
# Instance outputs
#
output "url" {
  description = "The URL of the wepapp"
  value       = "http://${module.webapp.vm_ip}"
}