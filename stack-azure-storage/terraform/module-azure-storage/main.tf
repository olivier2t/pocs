module "resource-group" {
  #####################################
  # Do not modify the following lines #
  source   = "./module-resource-group"
  project  = var.project
  env      = var.env
  customer = var.customer
  #####################################

  #. appName: ""
  #+ Name of the application. Must be between 3 and 24 characters, be lower case and only contain characters or numbers.
  appName = var.appName

  #. location: "west europe"
  #+ Azure location of the resource group. Must be either 'west europe', 'north europe', or 'east us' and lower case.
  location = var.location

  #. environment: "test"
  #+ Type of environment. Must be either 'prod', 'test', or 'dev' and lower case.
  environment = var.environment

  #. createdby: ""
  #+ Name of who created the resource.
  createdby = var.createdby
}

module "storage-account" {
  #####################################
  # Do not modify the following lines #
  source   = "./module-storage-account"
  project  = var.project
  env      = var.env
  customer = var.customer
  #####################################

  #. appName: ""
  #+ Name of the application. Must be between 3 and 24 characters, be lower case and only contain characters or numbers.
  appName = var.appName

  #. location: "west europe"
  #+ Azure location of the resource group. Must be either 'west europe', 'north europe', or 'east us' and lower case.
  location = var.location

  #. environment: "test"
  #+ Type of environment. Must be either 'prod', 'test', or 'dev' and lower case.
  environment = var.environment

  #. createdby: ""
  #+ Name of who created the resource.
  createdby = var.createdby

  #. account_kind: "StorageV2"
  #+ Type of storage account. Must be either 'FileStorage', 'Storage', or 'StorageV2'.
  account_kind = var.account_kind

  #. account_tier: "Standard"
  #+ Performance tier. Must be either 'Standard', or 'Premium'.
  account_tier = var.access_tier

  #. account_replication_type: "LRS"
  #+ Data redundancy. Must be either 'LRS', or 'GRS'."
  account_replication_type = var.account_replication_type

  #. access_tier: "Hot"
  #+ Default data access tier. Must be either 'Hot', or 'Cool'.
  access_tier = var.access_tier

  depends_on = [
    module.resource-group
  ]
}