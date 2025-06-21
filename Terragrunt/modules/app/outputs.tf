output "app_id" {
  description = "A map of app names and their IDs."
  value = {
    for app_key, app_resource in azurerm_windows_function_app.this :
    app_key => app_resource.id
  }
}

output "resource_group_name" {
  value       = var.resource_group_name
  description = "Azure Resource Group name"
}

output "location" {
  value       = var.location
  description = "location name"
}

output "public_network_access" {
  value       = var.public_network_access
  description = "The Public Network Access setting of the service. Possible values are Enabled and Disabled."
}

output "sku_name" {
  value       = var.sku_name
  description = "The SKU for the plan."
}