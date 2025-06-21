output "resource_group_name" {
  description = "Name of the resource group"
  value       = var.resource_group_name
}

output "servicebus_namespace_name" {
  description = "Name of the Service Bus namespace"
  value       = azurerm_servicebus_namespace.this.name
}

output "servicebus_namespace_id" {
  description = "ID of the Service Bus namespace"
  value       = azurerm_servicebus_namespace.this.id
}

output "servicebus_namespace_connection_string" {
  description = "Primary connection string for the Service Bus namespace"
  value       = azurerm_servicebus_namespace.this.default_primary_connection_string
  sensitive   = true
}

output "topic_ids" {
  description = "Map of topic names to their IDs"
  value = {
    for topic_name, topic in azurerm_servicebus_topic.topics : topic_name => topic.id
  }
}

output "topic_names" {
  description = "Map of logical topic names to their actual names"
  value = {
    for topic_name, topic in azurerm_servicebus_topic.topics : topic_name => topic.name
  }
}

output "subscription_ids" {
  description = "Map of subscription keys to their IDs"
  value = {
    for sub_key, subscription in azurerm_servicebus_subscription.subscriptions : sub_key => subscription.id
  }
}

output "subscription_names" {
  description = "Map of subscription keys to their actual names"
  value = {
    for sub_key, subscription in azurerm_servicebus_subscription.subscriptions : sub_key => subscription.name
  }
}

# output "send_authorization_rules" {
#   description = "Map of send authorization rule connection strings"
#   value = {
#     for topic_name, rule in azurerm_servicebus_topic_authorization_rule.topic_send : topic_name => rule.primary_connection_string
#   }
#   sensitive = true
# }

# output "listen_authorization_rules" {
#   description = "Map of listen authorization rule connection strings"  
#   value = {
#     for topic_name, rule in azurerm_servicebus_topic_authorization_rule.topic_listen : topic_name => rule.primary_connection_string
#   }
#   sensitive = true
# }