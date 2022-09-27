module "rg" {
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