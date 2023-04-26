output "private_ec2_ip" {
  value       = module.eks.private_ec2_ip
}

output "public_ec2_ip" {
  value       = module.eks.public_ec2_ip
}

output "cluster_security_group_id" {
    value   = module.eks.cluster_security_group_id
}

