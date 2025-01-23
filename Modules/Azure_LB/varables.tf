variable "lb_name" {
  description = "The name of the Load Balancer"
  type        = string
}

variable "location" {
  description = "The location of the Load Balancer"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "sku" {
  description = "The SKU of the Load Balancer"
  type        = string
  default     = "Standard"
}

variable "public_ip_name" {
  description = "The ID of the Public IP Address"
  type        = string
}

variable "backend_pool_name" {
  description = "The name of the Backend Address Pool"
  type        = string
}

variable "probe_name" {
  description = "The name of the Probe"
  type        = string
}

variable "probe_protocol" {
  description = "The protocol of the Probe"
  type        = string
  default     = "Tcp"
}

variable "probe_port" {
  description = "The port of the Probe"
  type        = number
}

variable "probe_interval" {
  description = "The interval of the Probe in seconds"
  type        = number
  default     = 5
}

variable "probe_count" {
  description = "The number of Probes"
  type        = number
  default     = 2
}

variable "lb_rule_name" {
  description = "The name of the Load Balancer Rule"
  type        = string
}

variable "lb_rule_protocol" {
  description = "The protocol of the Load Balancer Rule"
  type        = string
  default     = "Tcp"
}

variable "lb_rule_frontend_port" {
  description = "The frontend port of the Load Balancer Rule"
  type        = number
}

variable "lb_rule_backend_port" {
  description = "The backend port of the Load Balancer Rule"
  type        = number
}