resource "azurerm_log_analytics_workspace" "example" {
  name                = var.log_WorkspaceName
  location            = var.log_analytics_Rg_location
  resource_group_name = var.log_analytics_Rg_name
  sku                 = var.log_analytics_sku
  retention_in_days   = var.log_retention_days
}