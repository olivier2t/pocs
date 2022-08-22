resource "azurerm_network_security_group" "nginx" {
  name                = "${var.customer}-${var.project}-${var.env}-scalable-nginx"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location

  security_rule {
    name                       = "inbound-nginx"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = var.nginx_port
    destination_port_range     = var.nginx_port
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    Name = "${var.customer}-${var.project}-${var.env}-scalable-nginx"
  }
}