variable "log_WorkspaceName" {
  description = "Name of log analytics name"
  type = string
}

variable "log_analytics_Rg_location" {
  description = "location of log analytics"
  type = string
}

variable "log_analytics_Rg_name" {
  description = "name of the resource group"
  type = string
}

variable "log_analytics_sku" {
  description = "sku of log analytics workspace "
  type = string
  default = "PerGB2018"
}

variable "log_retention_days" {
    description = "number of days logs need to be retained"
    type = number
    default = 30
  
}