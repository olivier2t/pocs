data "azurerm_network_security_group" "nginx" {
  name                = "${var.aks_cluster_name}-nodes"
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_network_security_rule" "nginx" {
  name                        = "${var.customer}-${var.project}-${var.env}-scalable-nginx"
  resource_group_name         = data.azurerm_resource_group.rg.name
  network_security_group_name = data.azurerm_network_security_group.nginx.name

  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = var.nginx_port
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
}