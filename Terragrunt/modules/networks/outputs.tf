# output "network_security_group_id" {
#   description = "A map of NSG names and their IDs."
#   value = {
#     for network_security_group_key, network_security_group_resource in azurerm_network_security_group.this :
#     network_security_group_key => network_security_group_resource.id
#   }
# }

output "resource_group_name" {
  value       = var.resource_group_name
  description = "Azure Resource Group name"
}

output "location" {
  value       = var.location
  description = "location name"
}