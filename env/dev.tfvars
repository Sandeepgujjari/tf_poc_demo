subscription_id          = "95e24921-0503-43dc-968b-494278be7caf"
resource_group_name      = "tcs-poc-rg-01"
storage_account_name     = "stpoctcsdg08"
location                 = "East US2"
account_tier             = "Standard"
account_replication_type = "LRS"
container_names          = ["devtfstate"]
keyvault_name            = "kvpocdgtcs08"
app_gateway_name         = "app-gw-poc"
frontend_port            = 80
backend_port             = 80
tags                     = {
  environment = "dev"
  project     = "iac"
}
keyvault_location        = "East US2"
keyvault_rg_name         = "tcs-poc-rg-01"
object_ids               = ["5ea0a0ff-b35f-4b85-b0f9-d3c3759eca17", "1e8589de-eba4-4321-8a6c-58d95e968884"]
keyvault_sku             = "standard"
keyvault_soft_delete     = 7
windows_web_vm_name      = "web-vm-poc"
windows_app_vm_name      = "app-vm-poc"
vm_rg_location           = "East US2"
vm_rg_Name               = "tcs-poc-rg-01"
vm_Size                  = "Standard_B1ms"
vm_subnet_name           = "snet-tcs-poc-vm"
vnet_name                = "vnet-tcs-poc-eastus-01"
vnet_rg_name             = "tcs-poc-rg-01"
lb_name               = "tcs-poc-lb-01"
sku                   = "Standard"
public_ip_name        = "tcs-poc-pip-01"
backend_pool_name     = "example-backend-pool"
probe_name            = "example-probe"
probe_protocol        = "Tcp"
probe_port            = 80
probe_interval        = 5
probe_count           = 2
lb_rule_name          = "example-lb-rule"
lb_rule_protocol      = "Tcp"
lb_rule_frontend_port = 80
lb_rule_backend_port  = 80
windows_image_reference = {
  version   = "latest"
  sku       = "2016-Datacenter"
  offer     = "WindowsServer"
  publisher = "MicrosoftWindowsServer"
}
linux_web_vm_name = "web-vm-poc"
linux_image_reference = {
  version   = "latest"
  sku       = "8_7"
  offer     = "RHEL"
  publisher = "RedHat"
}
log_WorkspaceName         = "iacloganalyticspoc"
log_analytics_Rg_location = "East US2"
log_analytics_Rg_name     = "tcs-poc-rg-01"
windows_data_disks = [
  { lun = 1, disk_size_gb = 32, storage_account_type = "Standard_LRS" }
]

linux_data_disks = [
  { lun = 1, disk_size_gb = 32, storage_account_type = "Standard_LRS" }
]

#***************
#****mysql db
#**************
mysql_server_name                  = "iacmysqlpoc"
mysql_resource_group_name          = "tcs-poc-rg-01"
mysql_location                     = "East US2"
mysql_version                      = "8.0"
mysql_sku_name                     = "Standard_B1ms"
mysql_storage_mb                   = 5120
mysql_administrator_login          = "mysqladim"
mysql_administrator_login_password = "iacpoctest@123"
mysql_backup_retention_days        = 7
mysql_databases = {
  db01 = {
    name      = "mysqldb01"
    charset   = "utf8"
    collation = "utf8_unicode_ci"
  }
}

#***************
#****mysql  flexible db
#**************

mysql_flexible_server_name               = "tcspocflex"
mysql_flexible_resource_group_name       = "tcs-poc-rg-01"
mysql_flexible_location                  = "East US2"
mysql_flexible_administrator_login       = "flexadmin"
mysql_flexible_administrator_password    = "testpaassw@1"
mysql_flexible_subnet_name               = "snet-tcs-poc-sql"
mysql_flexible_vnet_name                 = "vnet-tcs-poc-eastus-01"
mysql_flexible_vnet_rg_name              = "tcs-poc-rg-01"
mysql_flexible_version                   = "8.0.21"
mysql_flexible_backup_retention_days     = 7
mysql_flexible_high_availability_mode    = "SameZone"
mysql_flexible_availability_zone         = 3
mysql_flexible_standby_availability_zone = 3
mysql_flexible_databases = {
  db01 = {
    name      = "mysqldb01"
    charset   = "utf8mb3"
    collation = "utf8mb3_unicode_ci"
  }
}
mysql_flexible_sku_name = "GP_Standard_D2ads_v5"
