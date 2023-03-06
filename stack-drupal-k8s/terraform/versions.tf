terraform {
  required_version = ">= 1.0"
  
  required_providers {
    kubernetes = {
      version = ">= 2.8.0"
    }

    helm = {
      version = ">= 2.4.1"
    }
  }
}