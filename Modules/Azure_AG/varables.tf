variable "name" {
  description = "The name of the Application Gateway"
  type        = string
}

variable "location" {
  description = "The Azure region where the Application Gateway will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "sku_name" {
  description = "The SKU of the Application Gateway (e.g., Standard_v2, WAF_v2)"
  type        = string
  default     = "Standard_v2"
}

variable "sku_tier" {
  description = "The SKU tier (e.g., Standard, WAF)"
  type        = string
  default     = "Standard_v2"
}

variable "capacity" {
  description = "The capacity of the Application Gateway instance"
  type        = number
  default     = 2
}

variable "subnet_id" {
  description = "The ID of the subnet for the Application Gateway"
  type        = string
}

variable "private_ip_address" {
  description = "The private IP address for the Application Gateway"
  type        = string
  default     = null
}

variable "private_ip_allocation" {
  description = "The allocation method for the private IP (Static or Dynamic)"
  type        = string
  default     = "Dynamic"
}

variable "frontend_port" {
  description = "The frontend port for the Application Gateway"
  type        = number
  default     = 80
}

variable "backend_port" {
  description = "The backend port for the Application Gateway"
  type        = number
  default     = 80
}

variable "backend_protocol" {
  description = "The backend protocol (Http or Https)"
  type        = string
  default     = "Http"
}

variable "listener_protocol" {
  description = "The protocol for the HTTP listener (Http or Https)"
  type        = string
  default     = "Http"
}

variable "cookie_based_affinity" {
  description = "Whether to enable cookie-based affinity (Enabled or Disabled)"
  type        = string
  default     = "Disabled"
}

variable "request_timeout" {
  description = "The request timeout in seconds"
  type        = number
  default     = 20
}

variable "tags" {
  description = "A map of tags to assign to the Application Gateway"
  type        = map(string)
  default     = {}
}
