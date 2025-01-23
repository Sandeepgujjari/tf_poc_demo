module "Resource_Group" {
  source  = "./Modules/Azure_RG"
  RG_Name = var.resource_group_name
}

module "storageaccount" {
  source                   = "./Modules/Azure_Storage_Account"
  resource_group_name      = var.resource_group_name
  storage_account_name     = var.storage_account_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  container_names          = var.container_names
  depends_on = [ module.Resource_Group ]
}
module "KeyVault" {
  source               = "./Modules/Azure_KeyVault"
  keyvault_location    = var.location
  keyvault_name        = var.keyvault_name
  keyvault_rg_name     = var.resource_group_name
  keyvault_soft_delete = var.keyvault_soft_delete
  keyvault_sku         = var.keyvault_sku
  object_ids           = var.object_ids
  depends_on = [ module.Resource_Group ]
}
module "vnet" {
  source              = "./Modules/Azure_Vnet"
  location            = var.location
  resource_group_name = var.resource_group_name
  vnet_name           = var.vnet_name
  address_space       = ["10.10.0.0/16"]

  subnets = {
    "web-subnet" = {
      name            = "web-subnet"
      address_prefix  = "10.10.1.0/24"
      delegation      = null
    },
    "db-subnet" = {
      name            = "db-subnet"
      address_prefix  = "10.10.2.0/24"
      delegation = [
        {
          name = "db-delegation"
          service_delegation = {
            name    = "Microsoft.DBforMySQL/flexibleServers"
            actions = [
              "Microsoft.Network/virtualNetworks/subnets/action",
              "Microsoft.Network/virtualNetworks/subnets/join/action"
            ]
          }
        }
      ]
    }
  }
  depends_on = [module.Resource_Group]
}


#  module "web_vm" {
#    source                     = "./Modules/Azure_Windows_VM"
#    count                      = 1
#    depends_on                 = [module.vnet, module.log_analytics]
#    vm_name                    = "${var.windows_web_vm_name}0${count.index + 1}"
#    vm_rg_location             = var.vm_rg_location
#    vm_rg_Name                 = var.resource_group_name
#    vm_Size                    = var.vm_Size
#    vm_subnet_name             = "web-subnet"
#    vnet_name                  = var.vnet_name
#    vnet_rg_name               = var.resource_group_name
#    image_reference            = var.windows_image_reference
#    keyvault_name              = var.keyvault_name
#    keyvault_rg_name           = var.keyvault_rg_name
#    data_disks                 = var.windows_data_disks
#    log_analytics_workspace_id = module.log_analytics.workspace_id
#    log_analytics_primary_key  = module.log_analytics.workspace_shared_key
#  }
#   module "app_vm" {
#    source                     = "./Modules/Azure_Windows_VM"
#    count                      = 1
#    depends_on                 = [module.vnet, module.log_analytics]
#    vm_name                    = "${var.windows_app_vm_name}0${count.index + 1}"
#    vm_rg_location             = var.vm_rg_location
#    vm_rg_Name                 = var.resource_group_name
#    vm_Size                    = var.vm_Size
#    vm_subnet_name             = "app-subnet"
#    vnet_name                  = var.vnet_name
#    vnet_rg_name               = var.resource_group_name
#    image_reference            = var.windows_image_reference
#    keyvault_name              = var.keyvault_name
#    keyvault_rg_name           = var.keyvault_rg_name
#    data_disks                 = var.windows_data_disks
#    log_analytics_workspace_id = module.log_analytics.workspace_id
#    log_analytics_primary_key  = module.log_analytics.workspace_shared_key
#  }
module "azure_lb" {
  source                = "./Modules/Azure_LB"
  lb_name               = var.lb_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  sku                   = var.sku
  public_ip_name        = var.public_ip_name
  backend_pool_name     = var.backend_pool_name
  probe_name            = var.probe_name
  probe_protocol        = var.probe_protocol
  probe_port            = var.probe_port
  probe_interval        = var.probe_interval
  probe_count           = var.probe_count
  lb_rule_name          = var.lb_rule_name
  lb_rule_protocol      = var.lb_rule_protocol
  lb_rule_frontend_port = var.lb_rule_frontend_port
  lb_rule_backend_port  = var.lb_rule_backend_port
  depends_on = [ module.Resource_Group ]
}
 module "web_vm" {
   source                     = "./Modules/Azure_Linux_VM"
   count                      = 1
   depends_on                 = [module.vnet, module.log_analytics,module.KeyVault]
   vm_name                    = "${var.linux_web_vm_name}0${count.index + 1}"
   vm_rg_location             = var.location
   vm_rg_Name                 = var.resource_group_name
   vm_Size                    = var.vm_Size
   vm_subnet_name             = "web-subnet"
   vnet_name                  = var.vnet_name
   vnet_rg_name               = var.resource_group_name
   image_reference            = var.linux_image_reference
   keyvault_name              = var.keyvault_name
   keyvault_rg_name           = var.resource_group_name
   data_disks                 = var.linux_data_disks
   log_analytics_workspace_id = module.log_analytics.workspace_id
   log_analytics_primary_key  = module.log_analytics.workspace_shared_key
 }

module "log_analytics" {
  source                    = "./Modules/Azure_log_Analytics"
  log_analytics_Rg_name     = var.resource_group_name
  log_WorkspaceName         = var.log_WorkspaceName
  log_analytics_Rg_location = var.log_analytics_Rg_location
  depends_on = [ module.Resource_Group ]
}

# module "mysql" {
#   source                       = "./Modules/Azure_MySql_DB"
#   mysql_server_name            = var.mysql_server_name
#   resource_group_name          = var.resource_group_name
#   location                     = var.mysql_location
#   mysql_version                = var.mysql_version
#   administrator_login          = var.mysql_administrator_login
#   administrator_login_password = var.mysql_administrator_login_password
#   sku_name                     = var.mysql_sku_name
#   storage_mb                   = var.mysql_storage_mb
#   backup_retention_days        = var.mysql_backup_retention_days
#   mysql_databases              = var.mysql_databases
# }

module "mysql_flexible" {
  source                     = "./Modules/Azure_MySql_flexible"
  mysql_flexible_server_name = var.mysql_flexible_server_name
  resource_group_name        = var.mysql_flexible_resource_group_name
  location                   = var.location
  administrator_login        = var.mysql_flexible_administrator_login
  administrator_password     = var.mysql_flexible_administrator_password
  subnet_name                = "db-subnet"
  vnet_name                  = var.mysql_flexible_vnet_name
  vnet_rg_name               = var.resource_group_name
  mysql_flexible_version     = var.mysql_flexible_version
  backup_retention_days      = var.mysql_flexible_backup_retention_days
  high_availability_mode     = var.mysql_flexible_high_availability_mode
  availability_zone          = var.mysql_flexible_availability_zone
  mysql_flexible_databases   = var.mysql_flexible_databases
  sku_name                   = var.mysql_flexible_sku_name
  standby_availability_zone = var.mysql_flexible_standby_availability_zone
  depends_on = [ module.Resource_Group, module.vnet ]      
}
