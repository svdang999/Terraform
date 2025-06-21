# variables.tf
# Data source variables
variable "resource_group_name" {
  description = "Name of the existing resource group"
  type        = string
}

variable "resource_group_name_network" {
  description = "Name of the existing resource group network"
  type        = string
}

variable "resource_group_name_ip" {
  description = "Name of the existing resource group for IP"
  type        = string
}

variable "subnet_name" {
  description = "Name of the existing subnet"
  type        = string
}

variable "virtual_network_name" {
  description = "Name of the existing virtual network"
  type        = string
}

variable "public_ip_name" {
  description = "Name of the existing public IP"
  type        = string
}

# Application Gateway variables
variable "name" {
  description = "Name of the Application Gateway"
  type        = string
  default     = "example-appgateway"
}

variable "sku_name" {
  description = "SKU name for the Application Gateway"
  type        = string
  default     = "Standard_v2"
  validation {
    condition = contains([
      "Standard_Small", "Standard_Medium", "Standard_Large",
      "Standard_v2", "WAF_Medium", "WAF_Large", "WAF_v2"
    ], var.sku_name)
    error_message = "SKU name must be one of the supported Application Gateway SKUs."
  }
}

variable "sku_tier" {
  description = "SKU tier for the Application Gateway"
  type        = string
  default     = "Standard_v2"
  validation {
    condition = contains([
      "Standard", "Standard_v2", "WAF", "WAF_v2"
    ], var.sku_tier)
    error_message = "SKU tier must be one of: Standard, Standard_v2, WAF, WAF_v2."
  }
}

variable "sku_capacity" {
  description = "SKU capacity for the Application Gateway"
  type        = number
  default     = 2
  validation {
    condition     = var.sku_capacity >= 1 && var.sku_capacity <= 125
    error_message = "SKU capacity must be between 1 and 125."
  }
}

variable "gateway_ip_configuration_name" {
  description = "Name of the gateway IP configuration"
  type        = string
  default     = "my-gateway-ip-configuration"
}

variable "frontend_port_name" {
  description = "Name of the frontend port"
  type        = string
  default     = "frontendport"
}

variable "frontend_port" {
  description = "Frontend port number"
  type        = number
  default     = 80
  validation {
    condition     = var.frontend_port >= 1 && var.frontend_port <= 65502
    error_message = "Frontend port must be between 1 and 65502."
  }
}

variable "frontend_ip_configuration_name" {
  description = "Name of the frontend IP configuration"
  type        = string
  default     = "frontendip"
}

variable "backend_address_pool_name" {
  description = "Name of the backend address pool"
  type        = string
  default     = "backendpool"
}

variable "http_setting_name" {
  description = "Name of the HTTP settings"
  type        = string
  default     = "httpsetting"
}

variable "cookie_based_affinity" {
  description = "Cookie based affinity setting"
  type        = string
  default     = "Disabled"
  validation {
    condition     = contains(["Enabled", "Disabled"], var.cookie_based_affinity)
    error_message = "Cookie based affinity must be either 'Enabled' or 'Disabled'."
  }
}

variable "backend_path" {
  description = "Backend path"
  type        = string
  default     = "/path1/"
}

variable "backend_port" {
  description = "Backend port number"
  type        = number
  default     = 80
  validation {
    condition     = var.backend_port >= 1 && var.backend_port <= 65535
    error_message = "Backend port must be between 1 and 65535."
  }
}

variable "backend_protocol" {
  description = "Backend protocol"
  type        = string
  default     = "Http"
  validation {
    condition     = contains(["Http", "Https"], var.backend_protocol)
    error_message = "Backend protocol must be either 'Http' or 'Https'."
  }
}

variable "request_timeout" {
  description = "Request timeout in seconds"
  type        = number
  default     = 60
  validation {
    condition     = var.request_timeout >= 1 && var.request_timeout <= 86400
    error_message = "Request timeout must be between 1 and 86400 seconds."
  }
}

variable "listener_name" {
  description = "Name of the HTTP listener"
  type        = string
  default     = "listener"
}

variable "frontend_protocol" {
  description = "Frontend protocol"
  type        = string
  default     = "Http"
  validation {
    condition     = contains(["Http", "Https"], var.frontend_protocol)
    error_message = "Frontend protocol must be either 'Http' or 'Https'."
  }
}

variable "request_routing_rule_name" {
  description = "Name of the request routing rule"
  type        = string
  default     = "routingrule"
}

variable "routing_rule_priority" {
  description = "Priority for the request routing rule"
  type        = number
  default     = 9
  validation {
    condition     = var.routing_rule_priority >= 1 && var.routing_rule_priority <= 20000
    error_message = "Routing rule priority must be between 1 and 20000."
  }
}

variable "routing_rule_type" {
  description = "Type of the request routing rule"
  type        = string
  default     = "Basic"
  validation {
    condition     = contains(["Basic", "PathBasedRouting"], var.routing_rule_type)
    error_message = "Routing rule type must be either 'Basic' or 'PathBasedRouting'."
  }
}

variable "tags" {
  description = "A map of tags to assign to the Application Gateway"
  type        = map(string)
  default     = {}
}

variable "identity" {
  description = "The name of the identity account"
  type        = string
  default     = null
}
