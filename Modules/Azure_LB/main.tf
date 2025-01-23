resource "azurerm_public_ip" "example" {
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}
resource "azurerm_lb" "example" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.example.id
  }
  depends_on = [ azurerm_public_ip.example ]
}

resource "azurerm_lb_backend_address_pool" "example" {
  name                = var.backend_pool_name
  loadbalancer_id     = azurerm_lb.example.id
  #resource_group_name = var.resource_group_name
}

resource "azurerm_lb_probe" "example" {
  name                = var.probe_name
  #resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.example.id
  protocol            = var.probe_protocol
  port                = var.probe_port
  interval_in_seconds = var.probe_interval
  number_of_probes    = var.probe_count
}

resource "azurerm_lb_rule" "example" {
  name                           = var.lb_rule_name
  #resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.example.id
  protocol                       = var.lb_rule_protocol
  frontend_port                  = var.lb_rule_frontend_port
  backend_port                   = var.lb_rule_backend_port
  frontend_ip_configuration_name = "PublicIPAddress"
  #backend_address_pool_id        = azurerm_lb_backend_address_pool.example.id
  probe_id                       = azurerm_lb_probe.example.id
}