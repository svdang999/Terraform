output "notification_hub_id" {
  description = "The ID of the  notification hub."
  value       = azurerm_notification_hub.this.id
}

output "notification_hub_namespace_id" {
  description = "The ID of the namespace notification hub."
  value       = azurerm_notification_hub_namespace.this.id
}