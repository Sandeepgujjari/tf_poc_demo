variable "location" {
  description = "The location for resources"
}

variable "resource_group_name" {
  description = "The name of the resource group"
}

variable "vnet_name" {
  description = "The name of the Virtual Network"
}

variable "address_space" {
  description = "Address space for the Virtual Network"
  type        = list(string)
}

variable "subnets" {
  description = "Map of subnets to create"
  type = map(object({
    name           = string
    address_prefix = string
    delegation     = list(object({
      name               = string
      service_delegation = object({
        name    = string
        actions = list(string)
      })
    }))
  }))
}
