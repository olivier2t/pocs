#
# Harbor Repository outputs
#
output "harbor_port" {
  description = "Port where Harbor Repository service is exposed"
  value = var.harbor_port
}