output "app_configuration_id" {
  description = "A map of app configurations and their IDs."
  value = {
    for app_key, app_resource in azurerm_app_configuration.this :
    app_key => app_resource.id
  }
}

output "resource_group_name" {
  value       = var.resource_group_name
  description = "Azure Resource Group name"
}

output "resource_group_name_network" {
  value       = var.resource_group_name_network
  description = "Azure Resource Group name for Network"
}

output "location" {
  value       = var.location
  description = "Identity location name"
}

output "sku" {
  value       = var.sku
  description = "Azure Resource Group name"
}

output "public_network_access" {
  value       = var.public_network_access
  description = "Identity location name"
}
