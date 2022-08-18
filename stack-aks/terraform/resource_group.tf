resource "azurerm_resource_group" "rg_aks" {
  name     = var.resource_group_name
  location = var.azure_location
  tags     = {
    "project"    = var.project,
    "env"        = var.env,
    "customer"   = var.customer,
    "cycloid.io" = "true",
  }
}