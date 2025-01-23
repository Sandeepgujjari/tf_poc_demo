data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "example" {
  name                        = var.keyvault_name
  location                    = var.keyvault_location
  resource_group_name         = var.keyvault_rg_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = var.keyvault_soft_delete
  purge_protection_enabled    = false
  tags = {
    "costcenter" = "99261"
    "managedby" = "SG"
  }

  sku_name = var.keyvault_sku

  
}

resource "azurerm_key_vault_access_policy" "example" {
  count = length(var.object_ids)
  key_vault_id = azurerm_key_vault.example.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = var.object_ids[count.index]

  key_permissions = [
    "Backup",
    "Create",
    "Decrypt",
    "Delete",
    "Encrypt",
    "Get",
    "Import",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Sign",
    "UnwrapKey",
    "Update",
    "Verify",
    "WrapKey"
  ]

  secret_permissions = [
    "Backup",
    "Delete",
    "Get",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Set"
  ]

  storage_permissions = [
    "Backup",
    "Delete",
    "DeleteSAS",
    "Get",
    "GetSAS",
    "List",
    "ListSAS",
    "Purge",
    "Recover",
    "RegenerateKey",
    "Restore",
    "Set",
    "SetSAS",
    "Update"
  ]
  depends_on = [ azurerm_key_vault.example ]
}