variable "keyvault_name" {
  description = "The name of the Key Vault"
  type        = string
}

variable "keyvault_rg_name" {
  description = "The name of the resource group containing the Key Vault"
  type        = string
}

variable "resource_type" {
  description = "The type of resource (windows_vm or linux_vm)"
  type        = string
}

variable "vm_name" {
  description = "The name of the VM"
  type        = string
}