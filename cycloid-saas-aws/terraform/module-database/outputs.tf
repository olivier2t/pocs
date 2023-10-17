###########
# Outputs #
###########

output "key_name" {
  description = "The SSH public key name to provision to EC2 servers"
  value       = aws_key_pair.cycloid.key_name
}
