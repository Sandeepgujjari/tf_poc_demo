# variables.tf

variable "mysql_server_name" {
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

variable "mysql_version" {
  description = "The version of the SQL Server"
  type = string
}

variable "administrator_login" {
  description = "The administrator login for the SQL Server"
  type = string
}
variable "administrator_login_password" {
  type = string
}
variable "mysql_databases" {
  type = any
}

variable "sku_name" {
  type = string
}

variable "storage_mb" {
  type = number
}

variable "backup_retention_days" {
  type = number
}