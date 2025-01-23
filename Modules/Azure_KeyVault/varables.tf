variable "keyvault_name" {
  type = string
}

variable "keyvault_location" {
  type = string
}

variable "keyvault_rg_name" {
  type = string
}

variable "keyvault_sku" {
  type = string
}

variable "keyvault_soft_delete" {
  type = number
}

variable "object_ids" {
  type = list(string)
}