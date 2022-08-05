output "bucket_names" {
  value       = module.s3.bucket_names
  description = "Name of s3 Buckets created"
  }


output "bucket_arns" {
  value       = module.s3.bucket_arns
  description = "ARNs of s3 Buckets created"
}