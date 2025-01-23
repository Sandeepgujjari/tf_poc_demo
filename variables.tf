variable "subscription_id" {
  type = string
  description = "SubscriptionID"
}
variable "resource_group_name" {
  description = "Name of the Resource Group"
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
variable "keyvault_name" {
  type = string
}

variable "keyvault_location" {
  type = string
}
variable "object_ids" {
  type = list(string)
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
## lb variables 

variable "lb_name" {
  description = "The name of the Load Balancer"
  type        = string
}

variable "sku" {
  description = "The SKU of the Load Balancer"
  type        = string
  default     = "Standard"
}

variable "public_ip_name" {
  description = "The ID of the Public IP Address"
  type        = string
}

variable "backend_pool_name" {
  description = "The name of the Backend Address Pool"
  type        = string
}

variable "probe_name" {
  description = "The name of the Probe"
  type        = string
}

variable "probe_protocol" {
  description = "The protocol of the Probe"
  type        = string
  default     = "Tcp"
}

variable "probe_port" {
  description = "The port of the Probe"
  type        = number
}

variable "probe_interval" {
  description = "The interval of the Probe in seconds"
  type        = number
  default     = 5
}

variable "probe_count" {
  description = "The number of Probes"
  type        = number
  default     = 2
}

variable "lb_rule_name" {
  description = "The name of the Load Balancer Rule"
  type        = string
}

variable "lb_rule_protocol" {
  description = "The protocol of the Load Balancer Rule"
  type        = string
  default     = "Tcp"
}

variable "lb_rule_frontend_port" {
  description = "The frontend port of the Load Balancer Rule"
  type        = number
}

variable "lb_rule_backend_port" {
  description = "The backend port of the Load Balancer Rule"
  type        = number
}
variable "windows_web_vm_name" {
  type = string
}
variable "windows_app_vm_name" {
  type = string
}
variable "vm_rg_Name" {
  type = string
}

variable "vm_rg_location" {
  type = string
}

variable "vm_subnet_name" {
  type = string
}

variable "vnet_rg_name" {
  type = string
}
variable "vnet_name" {
  type = string
}

variable "windows_image_reference" {
  description = "Configuration for the image"
  type        = map(string)
}

variable "vm_Size" {
  type = string
}

variable "linux_web_vm_name" {
  type = string
}
variable "linux_image_reference" {
  description = "Configuration for the image"
  type        = map(string)
}

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

variable "windows_data_disks" {
  description = "Data disk"
  type = list(any)
}

variable "linux_data_disks" {
  description = "Data disk"
  type = list(any)
}
variable "mysql_server_name" {
  description = "The name of the SQL Server"
  type        = string
}

variable "mysql_resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "mysql_location" {
  description = "The location of the SQL Server"
  type        = string
}

variable "mysql_version" {
  description = "The version of the SQL Server"
  type        = string
}

variable "mysql_administrator_login" {
  description = "The administrator login for the SQL Server"
  type        = string
}
variable "mysql_administrator_login_password" {
  type = string
}
variable "mysql_databases" {
  type = any
}

variable "mysql_sku_name" {
  type = string
}

variable "mysql_storage_mb" {
  type = number
}

variable "mysql_backup_retention_days" {
  type = number
}
#***************
#****mysql flexible db
#**************
# variables.tf
variable "mysql_flexible_subnet_name" {
  type = string
}

variable "mysql_flexible_vnet_name" {
  type = string
}

variable "mysql_flexible_vnet_rg_name" {
  type = string
}
variable "mysql_flexible_server_name" {
  description = "The name of the SQL Server"
  type = string
}

variable "mysql_flexible_resource_group_name" {
  description = "The name of the resource group"
  type = string
}

variable "mysql_flexible_location" {
  description = "The location of the SQL Server"
  type = string
}

variable "mysql_flexible_version" {
  description = "The version of the SQL Server"
  type = string
}

variable "mysql_flexible_administrator_login" {
  description = "The administrator login for the SQL Server"
  type = string
}
variable "mysql_flexible_administrator_password" {
  type = string
}
variable "mysql_flexible_databases" {
  type = any
}

variable "mysql_flexible_sku_name" {
  type = string
}

variable "mysql_flexible_high_availability_mode" {
  type = string
}
variable "mysql_flexible_availability_zone" {
  type = number
}
variable "mysql_flexible_backup_retention_days" {
  type = number
}
variable "mysql_flexible_standby_availability_zone" {
  type = number
}
