
output "bucket_names" {
  value       = [for bucket in aws_s3_bucket.bucket : bucket.id]
  description = "Name of s3 Buckets created"
  }


output "bucket_arns" {
  value       = [for bucket in aws_s3_bucket.bucket : bucket.arn]
  description = "ARNs of s3 Buckets created"
  }