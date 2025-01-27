terraform {
  backend "azurerm" {
    resource_group_name  = "poc_demo_rg"
    storage_account_name = "iacstorageaccountpocdemo"
    container_name       = "devtfstate"
    key                  = "devtfstatefile"
  }
}
