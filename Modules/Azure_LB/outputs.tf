output "lb_id" {
  description = "The ID of the Load Balancer"
  value       = azurerm_lb.example.id
}

output "backend_pool_id" {
  description = "The ID of the Backend Address Pool"
  value       = azurerm_lb_backend_address_pool.example.id
}

output "probe_id" {
  description = "The ID of the Probe"
  value       = azurerm_lb_probe.example.id
}

output "lb_rule_id" {
  description = "The ID of the Load Balancer Rule"
  value       = azurerm_lb_rule.example.id
}