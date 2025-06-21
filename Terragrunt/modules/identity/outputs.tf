output "user_assigned_identity_id" {
  value       = var.names
  description = "Azure Identity id"
}


output "resource_group_name" {
  value       = var.resource_group_name
  description = "Azure Resource Group name"
}

output "location" {
  value       = var.location
  description = "Identity location name"
}
