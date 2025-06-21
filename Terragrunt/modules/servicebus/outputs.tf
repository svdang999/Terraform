output "servicebus_namespace_id" {
  value       = var.names_servicebus
  description = "Azure Service Bus name"
}

output "eventhub_namespace_id" {
  value       = var.names_eventhub
  description = "Azure Event Hub name"
}

output "resource_group_name" {
  value       = var.resource_group_name
  description = "Azure Resource Group name"
}

output "location" {
  value       = var.location
  description = "location name"
}