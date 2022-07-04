# Cycloid variables
variable "env" {}
variable "project" {}
variable "customer" {}

# AWS variables
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {
  description = "AWS region where to create servers."
  default     = "eu-west-1"
}
variable "vm_instance_type" {}
variable "vm_disk_size" {}
variable "keypair_public" {}
variable "team_id" {}
variable "worker_key" {}