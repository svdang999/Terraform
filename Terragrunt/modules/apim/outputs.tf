output "apim_ext_id" {
  description = "A map of APIM external names and their IDs."
  value = {
    for app_key, app_resource in azurerm_api_management.ext :
    app_key => app_resource.id
  }
}


output "apim_int_id" {
  description = "A map of APIM internal names and their IDs."
  value = {
    for app_key, app_resource in azurerm_api_management.int :
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