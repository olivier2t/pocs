resource "azurerm_postgresql_server" "pgsql" {
  name                = "${var.customer}-${var.project}-${var.env}-pgsql"
  location            = var.azure_location
  resource_group_name = data.azurerm_resource_group.rg.name

  administrator_login          = var.administrator_login
  administrator_login_password = random_password.password.result

  sku_name   = "B_Gen5_1"
  version    = "11"
  storage_mb = 10240

  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = true

  public_network_access_enabled    = true
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"
}
