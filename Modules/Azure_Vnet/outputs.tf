output "subnet_ids" {
  description = "A map of subnet names to their IDs"
  value = { for subnet_name, subnet in var.subnets :
    subnet_name => azurerm_subnet.subnets[subnet_name].id
  }
}
