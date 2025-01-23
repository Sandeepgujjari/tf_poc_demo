# variables.tf
variable "subnet_name" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "vnet_rg_name" {
  type = string
}
variable "mysql_flexible_server_name" {
  description = "The name of the SQL Server"
  type = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type = string
}

variable "location" {
  description = "The location of the SQL Server"
  type = string
}

variable "mysql_flexible_version" {
  description = "The version of the SQL Server"
  type = string
}

variable "administrator_login" {
  description = "The administrator login for the SQL Server"
  type = string
}
variable "administrator_password" {
  type = string
}
variable "mysql_flexible_databases" {
  type = any
}

variable "sku_name" {
  type = string
}

variable "high_availability_mode" {
  type = string
    validation {
    condition     = var.high_availability_mode == "SameZone" || var.high_availability_mode == "ZoneRedundant"
    error_message = "Invalid value for high_availability_mode. Allowed values are SameZone or ZoneRedundant."
  }
}
variable "availability_zone" {
  type = number
}
variable "standby_availability_zone" {
  type = number
}
variable "backup_retention_days" {
  type = number
}