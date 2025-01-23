module "vm_password" {
  source           = "../Password_mgmt"
  resource_type    = "linux_vm"
  vm_name          = var.vm_name
  keyvault_name    = var.keyvault_name
  keyvault_rg_name = var.keyvault_rg_name
}

data "azurerm_subnet" "this" {
  name                 = var.vm_subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_rg_name
}

resource "azurerm_network_interface" "example" {
  name                = "${var.vm_name}-nic"
  location            = var.vm_rg_location
  resource_group_name = var.vm_rg_Name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.this.id
    private_ip_address_allocation = "Dynamic"
  }
  tags = {
    "costcenter" = "99261"
    "managedby" = "SG"
  }
}
resource "azurerm_linux_virtual_machine" "example" {
  name                = var.vm_name
  resource_group_name = var.vm_rg_Name
  location            = var.vm_rg_location
  size                = var.vm_Size
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]
  identity {
    type = "SystemAssigned"
  }
  admin_ssh_key {
    username   = "adminuser"
    public_key = module.vm_password.linux_vm
  }

  os_disk {
    caching              = var.os_disk["caching"]
    storage_account_type = var.os_disk["type"]
    disk_size_gb         = var.os_disk["size"]
  }
  source_image_reference {
    publisher = var.image_reference["publisher"]
    offer     = var.image_reference["offer"]
    sku       = var.image_reference["sku"]
    version   = var.image_reference["version"]
  }
  tags = {
    "costcenter" = "99261"
    "managedby" = "SG"
  }
  depends_on = [ module.vm_password ]
}
#*******************************************
#*****Azure vm managed disk
#*******************************************
resource "azurerm_managed_disk" "example" {
  for_each             = { for dd in var.data_disks : dd.lun => dd }
  name                 = lookup(each.value, "name", "${var.vm_name}-data-disk-${each.key}")
  resource_group_name  = var.vm_rg_Name
  location             = var.vm_rg_location
  storage_account_type = lookup(each.value, "storage_account_type", "Standard_LRS")
  create_option        = lookup(each.value, "create_option", "Empty")
  disk_size_gb         = each.value.disk_size_gb
  tags = {
    "costcenter" = "99261"
    "managedby" = "SG"
  }
}

resource "azurerm_virtual_machine_data_disk_attachment" "example" {
  for_each           = { for dd in var.data_disks : dd.lun => dd }
  managed_disk_id    = azurerm_managed_disk.example[each.key].id
  virtual_machine_id = azurerm_linux_virtual_machine.example.id
  lun                = each.key
  caching            = "ReadWrite"
}
#****************************************************
#**********Azure montioring and Lognalytics setup
#*****************************************************
resource "azurerm_virtual_machine_extension" "example" {
  name                       = "${var.vm_name}-monitoring"
  virtual_machine_id         = azurerm_linux_virtual_machine.example.id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorlinuxAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = "true"
  automatic_upgrade_enabled  = "true"
}

resource "azurerm_monitor_data_collection_rule" "example" {
  name                = "${var.vm_name}-rules"
  resource_group_name = var.vm_rg_Name
  location            = var.vm_rg_location

  destinations {
    log_analytics {
      workspace_resource_id = var.log_analytics_workspace_id
      name                  = "${var.vm_name}-destination-log"
    }
  }

  data_flow {
    streams      = ["Microsoft-InsightsMetrics"]
    destinations = ["${var.vm_name}-destination-log"]
  }

  data_sources {
    performance_counter {
      streams                       = ["Microsoft-InsightsMetrics"]
      sampling_frequency_in_seconds = 60
      counter_specifiers            = ["\\Processor(_Total)\\% Processor Time"]
      name                          = "VMInsightsPerfCounters"
    }
  }
}

# associate to a Data Collection Rule
resource "azurerm_monitor_data_collection_rule_association" "example1" {
  name                    = "${var.vm_name}-dcra"
  target_resource_id      = azurerm_linux_virtual_machine.example.id
  data_collection_rule_id = azurerm_monitor_data_collection_rule.example.id
  description             = "${var.vm_name} Data Collection Rule "
}