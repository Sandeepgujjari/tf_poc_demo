resource "azurerm_resource_group" "rg" {
  name     = var.RG_Name
  location = "East US2"
}