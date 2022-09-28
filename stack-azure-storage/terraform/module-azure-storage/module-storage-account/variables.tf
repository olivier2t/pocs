#these are the default variables for all resources
variable "appName" {
    description     = "Name of the application"
    type            = string
    
    validation {
        condition = (
                length(var.appName) >=3 &&
                length(var.appName) <=24 &&
                can(regex("[a-z.*]|[0-9]", var.appName))
        )
        error_message = "STOP! The appName value must be between 3 and 24 characters, be lower case and only contain characters or numbers."
    }
}

variable "location" {
    description     = "Azure location of the resource group"
    type            = string
    
    validation {
        condition = anytrue([
            var.location == "west europe",
            var.location == "north europe",
            var.location == "east us"
        ])
        error_message = "STOP! The location must be either 'west europe', 'north europe', or 'east us' and lower case."
    }
}

variable "environment" {
    description     = "Type of environment; PROD or DEV"
    type            = string
    
    validation {
        condition = anytrue([
            var.environment == "prod",
            var.environment == "test",
            var.environment == "dev"
        ])
        error_message = "STOP! The environment must be either 'prod', 'test', or 'dev' and lower case."
    }
}

variable "createdby" {
    description     = "Name of who created the resource"
    type            = string
}

#this section define resource specific settings

variable "account_kind" {
    description     = "Type of storage account"
    type            = string

    validation {
        condition = anytrue([
            var.account_kind == "FileStorage",
            var.account_kind == "Storage",
            var.account_kind == "StorageV2"
        ])
        error_message = "STOP! The account kind must be either 'FileStorage', 'Storage', or 'StorageV2'."
    }
}

variable "account_tier" {
    description     = "Performance tier"
    type            = string

    validation {
        condition = anytrue([
            var.account_tier == "Standard",
            var.account_tier == "Premium"
        ])
        error_message = "STOP! The performance tier must be either 'Standard', or 'Premium'."
    }
}

variable "account_replication_type" {
    description     = "Data redundancy"
    type            = string

    validation {
        condition = anytrue([
            var.account_replication_type == "LRS",
            var.account_replication_type == "GRS"
        ])
        error_message = "STOP! The redundancy must be either 'LRS', or 'GRS'."
    }
}

variable "access_tier" {
    description     = "Default data access tier"
    type            = string

    validation {
        condition = anytrue([
            var.access_tier == "Hot",
            var.access_tier == "Cool"
        ])
        error_message = "STOP! The data access tier must be either 'Hot', or 'Cool'."
    }
}

# Cycloid vars
variable "project" {
  description = "Cycloid project name."
}

variable "env" {
  description = "Cycloid environment name."
}

variable "customer" {
  description = "Cycloid customer name."
}

# Adding local tags to reflect usual ways of working in Cycloid stacks
variable "extra_tags" {
  description = "Extra tags to add to all resources in this module."
  default     = {}
}

locals {
  standard_tags = {
    "cycloid"    = "true"
    env          = var.env
    project      = var.project
    customer     = var.customer
  }
  merged_tags = merge(local.standard_tags, var.extra_tags)
}
