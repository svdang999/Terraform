# outputs.tf
# Data source outputs
output "resource_group_id" {
  description = "The ID of the resource group"
  value       = data.azurerm_resource_group.this.id
}

output "resource_group_location" {
  description = "The location of the resource group"
  value       = data.azurerm_resource_group.this.location
}

output "subnet_id" {
  description = "The ID of the subnet"
  value       = data.azurerm_subnet.this.id
}

output "subnet_address_prefixes" {
  description = "The address prefixes of the subnet"
  value       = data.azurerm_subnet.this.address_prefixes
}

output "public_ip_id" {
  description = "The ID of the public IP"
  value       = data.azurerm_public_ip.this.id
}

output "public_ip_address" {
  description = "The public IP address"
  value       = data.azurerm_public_ip.this.ip_address
}

output "public_ip_fqdn" {
  description = "The FQDN of the public IP"
  value       = data.azurerm_public_ip.this.fqdn
}

# Application Gateway outputs
output "application_gateway_id" {
  description = "The ID of the Application Gateway"
  value       = azurerm_application_gateway.this.id
}

output "application_gateway_name" {
  description = "The name of the Application Gateway"
  value       = azurerm_application_gateway.this.name
}

output "application_gateway_location" {
  description = "The location of the Application Gateway"
  value       = azurerm_application_gateway.this.location
}

output "application_gateway_resource_group_name" {
  description = "The resource group name of the Application Gateway"
  value       = azurerm_application_gateway.this.resource_group_name
}

output "application_gateway_sku" {
  description = "The SKU configuration of the Application Gateway"
  value = {
    name     = azurerm_application_gateway.this.sku[0].name
    tier     = azurerm_application_gateway.this.sku[0].tier
    capacity = azurerm_application_gateway.this.sku[0].capacity
  }
}

output "application_gateway_frontend_ip_configuration" {
  description = "The frontend IP configuration of the Application Gateway"
  value = {
    name                 = azurerm_application_gateway.this.frontend_ip_configuration[0].name
    public_ip_address_id = azurerm_application_gateway.this.frontend_ip_configuration[0].public_ip_address_id
    private_ip_address   = try(azurerm_application_gateway.this.frontend_ip_configuration[0].private_ip_address, null)
  }
}

# Combined outputs for easy reference
output "application_gateway_summary" {
  description = "Summary of key Application Gateway information"
  value = {
    id                  = azurerm_application_gateway.this.id
    name                = azurerm_application_gateway.this.name
    location            = azurerm_application_gateway.this.location
    resource_group_name = azurerm_application_gateway.this.resource_group_name
    public_ip_address   = data.azurerm_public_ip.this.ip_address
    public_ip_fqdn      = data.azurerm_public_ip.this.fqdn
    sku_tier            = azurerm_application_gateway.this.sku[0].tier
    sku_name            = azurerm_application_gateway.this.sku[0].name
  }
}