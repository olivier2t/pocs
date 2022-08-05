
variable "s3_buckets" {
    description = "List of s3 Buckets (Objects)"
    default = []
}

variable "s3_bucket_objects" {
    description = "Create objects in s3 buckets"
    default = []
}

variable "environment" {
    description = "S3 Bucket Environment"
    default     = "Dev"
}

