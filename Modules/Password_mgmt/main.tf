# dynamically retrieve the key vault
data "azurerm_key_vault" "this" {
  name                = var.keyvault_name
  resource_group_name = var.keyvault_rg_name
}

#*********************************************
#*** type == windows_vm
#**********************************************

resource "random_password" "win_vm_pwd" {
  count   = var.resource_type == "windows_vm" ? 1 : 0
  length  = 40
  special = true
}

resource "azurerm_key_vault_secret" "win_vm_key" {
  count        = var.resource_type == "windows_vm" ? 1 : 0
  name         = replace("${var.vm_name}", "_", "-")
  value        = random_password.win_vm_pwd[0].result
  key_vault_id = data.azurerm_key_vault.this.id
  lifecycle {
    ignore_changes = [value, expiration_date]
  }
}

#*********************************************
#*** type == linux vm
#**********************************************

resource "tls_private_key" "linux_ssh_key" {
  count    = var.resource_type == "linux_vm" ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_key_vault_secret" "linux_ssh_private_key" {
  count        = var.resource_type == "linux_vm" ? 1 : 0
  name         = replace("${var.vm_name}-privatekey", "_", "-")
  value        = tls_private_key.linux_ssh_key[0].private_key_pem
  key_vault_id = data.azurerm_key_vault.this.id
  lifecycle {
    ignore_changes = [value, expiration_date]
  }
}

resource "azurerm_key_vault_secret" "linux_ssh_public_key" {
  count        = var.resource_type == "linux_vm" ? 1 : 0
  name         = replace("${var.vm_name}-publickey", "_", "-")
  value        = tls_private_key.linux_ssh_key[0].public_key_openssh
  key_vault_id = data.azurerm_key_vault.this.id
  lifecycle {
    ignore_changes = [value, expiration_date]
  }
}