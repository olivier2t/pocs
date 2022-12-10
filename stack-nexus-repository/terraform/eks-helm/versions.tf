terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.3.0"
    }

    kubernetes = {
      version = ">= 2.8.0"
    }

    helm = {
      version = ">= 2.4.1"
    }
  }
}