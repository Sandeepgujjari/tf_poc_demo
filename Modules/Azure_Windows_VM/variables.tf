variable "vm_name" {
  type = string
}

variable "vm_rg_Name" {
  type = string
}

variable "vm_rg_location" {
  type = string
}

variable "os_disk" {
  description = "Configuration for the OS disk"
  type        = map(string)

  default = {
    caching = "ReadWrite"
    type    = "Standard_LRS"
    size    = "128"
  }
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

variable "image_reference" {
  description = "Configuration for the image"
  type        = map(string)
}


variable "vm_Size" {
  type = string
}

variable "keyvault_name" {
  type = string
}

variable "keyvault_rg_name" {
  type = string
}

variable "data_disks" {
  type = list(any)
  default = [  ]
  validation {
    condition = alltrue([
        for dd in var.data_disks : lookup(dd, "disk_size_gb", null) != null ? true : false
    ])
    error_message = "All disks need to have disk_size_gb specified"
  }
  validation {
    condition = alltrue([
        for dd in var.data_disks : lookup(dd, "lun", null) != null ? true : false
    ])
    error_message = "All disks need to have lun specified"
  }
}
variable "log_analytics_workspace_id" {
  description = "log analytics workspace id"
  type = string
}

variable "log_analytics_primary_key" {
  description = "log analytics workspace id"
  type = string
}