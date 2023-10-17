output "core_private_dns" {
  description = "The private DNS name of the Cycloid core EC2 servers"
  value       = aws_instance.cycloid-core[*].private_dns
}

output "core_os_user" {
  description = "Admin username connect to instance via SSH"
  value       = var.core_os_user
}
output "iam_ses_user_key" {
  value = try(aws_iam_access_key.ses.id, "")
}

output "iam_ses_user_secret" {
  value     = try(aws_iam_access_key.ses.secret, "")
  sensitive = true
}

output "iam_ses_smtp_user_key" {
  value = try(aws_iam_access_key.ses.id, "")
}

output "iam_ses_smtp_user_secret" {
  value     = try(aws_iam_access_key.ses.ses_smtp_password_v4, "")
  sensitive = true
}

output "cycloid_sg_id" {
  value = aws_security_group.cycloid-core
}
