variable "resource_group_name" {
  description = "The name of the Azure resource group."
  type        = string
}

variable "storage_account_name" {
  description = "The name of the Azure Storage Account."
  type        = string
}

variable "location" {
  description = "The Azure region where the Storage Account will be created."
  type        = string
}

variable "account_tier" {
  description = "The storage account performance tier (e.g., Standard, Premium)."
  type        = string
}

variable "account_replication_type" {
  description = "The replication type for the storage account (e.g., LRS, GRS)."
  type        = string
}

variable "container_names" {
  description = "A list of container names to create within the Storage Account."
  type        = list(string)
}