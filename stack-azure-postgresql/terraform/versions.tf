terraform {
  required_version = "~> 1.1.0"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.78.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.4.3"
    }
  }
}