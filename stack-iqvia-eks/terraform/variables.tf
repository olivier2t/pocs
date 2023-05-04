# Cycloid variables
variable "env" {}
variable "project" {}
variable "customer" {}

# AWS variables
variable "aws_cred" {
  description = "Contains AWS access_key and secret_key"
}
variable "aws_region" {
  description = "AWS region where to create servers."
  default     = "eu-west-1"
}
variable "git_iac" {
  description = "Git where the IaC resides."
  default = "https://github.com/olivier2t/iac-library.git"
}
