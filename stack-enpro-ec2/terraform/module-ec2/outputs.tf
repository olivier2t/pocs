#
# Instance outputs
#
output "vm_ip" {
  description = "The IP address the EC2 instance"
  value       = aws_instance.ec2.public_ip
}