#
# Harbor Repository outputs
#
output "harbor_port" {
  description = "Port where Harbor Repository service is exposed"
  value       = module.harbor.harbor_port
}