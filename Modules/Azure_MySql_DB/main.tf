resource "azurerm_mysql_server" "example" {
  name                = var.mysql_server_name
  resource_group_name = var.resource_group_name
  location            = var.location

  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password


  sku_name                         = var.sku_name
  storage_mb                       = var.storage_mb
  version                          = var.mysql_version
  backup_retention_days            = var.backup_retention_days
  public_network_access_enabled    = true
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"
}

resource "azurerm_mysql_database" "example" {
  for_each            = var.mysql_databases
  name                = each.value.name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_server.example.name
  charset             = each.value.charset
  collation           = each.value.collation
}
