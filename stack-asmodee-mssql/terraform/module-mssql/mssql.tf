resource "azurerm_mssql_server" "asmodee" {
  name                         = var.mssql_servername
  resource_group_name          = data.azurerm_resource_group.asmodee.name
  location                     = data.azurerm_resource_group.asmodee.location
  version                      = "12.0"
  administrator_login          = var.mssql_administrator_login
  administrator_login_password = var.mssql_administrator_login_password
}

resource "azurerm_mssql_database" "asmodee" {
  name           = var.mssql_database
  server_id      = azurerm_mssql_server.asmodee.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 4
  read_scale     = true
  sku_name       = "S0"
  zone_redundant = false

  tags = {
    foo = "bar"
  }
}
