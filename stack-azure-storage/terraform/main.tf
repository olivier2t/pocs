module "sa" {
  #####################################
  # Do not modify the following lines #
  source   = "./module-storage-account"
  project  = var.project
  env      = var.env
  customer = var.customer
  #####################################

  #. appName: ""
  #+ Name of the application. Must be between 3 and 24 characters, be lower case and only contain characters or numbers.
  appName = "Module values are injected by StackForms (.forms.yml) when defined. These vales are orverriden."

  #. location: "west europe"
  #+ Azure location of the resource group. Must be either 'west europe', 'north europe', or 'east us' and lower case.
  location = "west europe"

  #. environment: "test"
  #+ Type of environment. Must be either 'prod', 'test', or 'dev' and lower case.
  environment = "test"

  #. createdby: ""
  #+ Name of who created the resource.
  createdby = module.rg.createdby

  #. account_kind: "StorageV2"
  #+ Type of storage account. Must be either 'FileStorage', 'Storage', or 'StorageV2'.
  account_kind = "StorageV2"

  #. account_tier: "Standard"
  #+ Performance tier. Must be either 'Standard', or 'Premium'.
  account_tier = "Standard"

  #. account_replication_type: "LRS"
  #+ Data redundancy. Must be either 'LRS', or 'GRS'."
  account_replication_type = "LRS"

  #. access_tier: "Hot"
  #+ Default data access tier. Must be either 'Hot', or 'Cool'.
  access_tier = "Hot"
}