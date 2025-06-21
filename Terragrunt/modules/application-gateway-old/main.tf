# Data sources for existing resources
data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

data "azurerm_resource_group" "network" {
  name = var.resource_group_name_network
}

data "azurerm_resource_group" "ip" {
  name = var.resource_group_name_ip
}

data "azurerm_subnet" "this" {
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = data.azurerm_resource_group.network.name
}

data "azurerm_public_ip" "this" {
  name                = var.public_ip_name
  resource_group_name = data.azurerm_resource_group.ip.name
}

# import {
#   to = azurerm_application_gateway.this
#   id = "/subscriptions/fdea6769-b01e-4a30-a3c6-dd170eb79a22/resourceGroups/rg-splg-commp-crm-gw-ger-01/providers/Microsoft.Network/applicationGateways/${var.name}"  
# }

# Application Gateway resource
resource "azurerm_application_gateway" "this" {
  name                = var.name
  resource_group_name = data.azurerm_resource_group.this.name
  location            = data.azurerm_resource_group.this.location

  identity {
    type = "UserAssigned"
    identity_ids = [
      var.identity      
    ]
  }

  sku {
      name     = var.sku_name
      tier     = var.sku_tier
      capacity = var.sku_capacity
  }

  gateway_ip_configuration {
      name      = var.gateway_ip_configuration_name
      subnet_id = data.azurerm_subnet.this.id
  }

  frontend_port {
      name = var.frontend_port_name
      port = var.frontend_port
  }

  frontend_ip_configuration {
      name                 = var.frontend_ip_configuration_name
      public_ip_address_id = data.azurerm_public_ip.this.id
  }

  backend_address_pool {
      name = var.backend_address_pool_name
  }

  backend_http_settings {
      name                  = var.http_setting_name
      cookie_based_affinity = var.cookie_based_affinity
      path                  = var.backend_path
      port                  = var.backend_port
      protocol              = var.backend_protocol
      request_timeout       = var.request_timeout
  }

  http_listener {
      name                           = var.listener_name
      frontend_ip_configuration_name = var.frontend_ip_configuration_name
      frontend_port_name             = var.frontend_port_name
      protocol                       = var.frontend_protocol
  }

  request_routing_rule {
      name                       = var.request_routing_rule_name
      priority                   = var.routing_rule_priority
      rule_type                  = var.routing_rule_type
      http_listener_name         = var.listener_name
      backend_address_pool_name  = var.backend_address_pool_name
      backend_http_settings_name = var.http_setting_name
  }

  lifecycle {
      ignore_changes = [
        tags,
        zones,
        backend_address_pool,
        backend_http_settings,
        frontend_ip_configuration,
        http_listener,
        request_routing_rule,
        ssl_certificate,
        url_path_map,
        trusted_root_certificate,
        autoscale_configuration,
        enable_http2,
        firewall_policy_id,
        frontend_port,
        gateway_ip_configuration,
        sku,
        probe,
        ssl_profile,
        trusted_client_certificate,
        rewrite_rule_set,
        private_link_configuration,
        identity,
        force_firewall_policy_association
    ]
  }
}