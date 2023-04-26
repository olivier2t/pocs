# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 4.0"
#     }
#   }
# }

# provider "aws" {
#   region = "us-east-1"
#   profile = "certifai_125_dev"
# }

variable "cluster_name" {
  default = "certifai-125-eks-dev"
}

variable "cluster_version" {
  default = "1.25"
}
