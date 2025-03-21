resource "azurerm_public_ip" "example" {
  name                = "${var.name}-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}
resource "azurerm_application_gateway" "app_gateway" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku {
    name     = var.sku_name
    tier     = var.sku_tier
    capacity = var.capacity
  }

  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = var.subnet_id
  }

  frontend_ip_configuration {
    name                 = "appGatewayFrontendIp"
    public_ip_address_id = azurerm_public_ip.example.id
  }
  frontend_port {
    name = "frontendPort"
    port = var.frontend_port
  }

  backend_address_pool {
    name = "backendPool"
  }

  backend_http_settings {
    name                  = "httpSettings"
    cookie_based_affinity = var.cookie_based_affinity
    port                  = var.backend_port
    protocol              = var.backend_protocol
    request_timeout       = var.request_timeout
  }

  http_listener {
    name                           = "httpListener"
    frontend_ip_configuration_name = "appGatewayFrontendIp"
    frontend_port_name             = "frontendPort"
    protocol                       = var.listener_protocol
  }

  request_routing_rule {
    name                       = "routingRule"
    rule_type                  = "Basic"
    http_listener_name         = "httpListener"
    backend_address_pool_name  = "backendPool"
    backend_http_settings_name = "httpSettings"
    priority  = 100
  }

  tags = var.tags
  depends_on = [ azurerm_public_ip.example ]
}
