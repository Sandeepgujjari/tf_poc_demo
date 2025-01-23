data "azurerm_subnet" "flxible_subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_rg_name
}

resource "azurerm_mysql_flexible_server" "example" {
  name                   = var.mysql_flexible_server_name
  resource_group_name    = var.resource_group_name
  location               = var.location
  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password
  backup_retention_days  = var.backup_retention_days
  delegated_subnet_id    = data.azurerm_subnet.flxible_subnet.id
  private_dns_zone_id    = azurerm_private_dns_zone.example.id
  version                = var.mysql_flexible_version
  zone                   = var.availability_zone
  # private_dns_zone_id    = azurerm_private_dns_zone.example.id
  sku_name = var.sku_name
  high_availability {
    mode                      = var.high_availability_mode
    standby_availability_zone = var.standby_availability_zone
  }
  depends_on = [azurerm_private_dns_zone_virtual_network_link.example]
}
resource "azurerm_private_dns_zone" "example" {
  name                = "${var.mysql_flexible_server_name}.privatelink.mysql.database.azure.com"
  resource_group_name = var.resource_group_name
}

data "azurerm_virtual_network" "example" {
  name                = var.vnet_name
  resource_group_name = var.vnet_rg_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "example" {
  name                  = "${var.mysql_flexible_server_name}.mysql.database.azure.com"
  private_dns_zone_name = azurerm_private_dns_zone.example.name
  virtual_network_id    = data.azurerm_virtual_network.example.id
  resource_group_name   = var.resource_group_name
}
resource "azurerm_mysql_flexible_database" "example" {
  for_each            = var.mysql_flexible_databases
  name                = each.value.name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.example.name
  charset             = each.value.charset
  collation           = each.value.collation
}
