data "azurerm_resource_group" "cycloid-worker" {
  name     = "cycloid-demo"
}

# resource "azurerm_resource_group" "cycloid-worker" {
#   name     = "${var.customer}-${var.project}-${var.env}-cycloid-worker"
#   location = var.azure_location
# }