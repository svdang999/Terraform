resource "azurerm_servicebus_namespace" "this" {
  name                = var.servicebus_namespace_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.servicebus_sku
  
  tags = merge(var.tags, {
    component = "servicebus"
  })
}

# Service Bus Topics 
resource "azurerm_servicebus_topic" "topics" {
  for_each = var.topics
  
  name                  = each.key
  namespace_id          = azurerm_servicebus_namespace.this.id
  partitioning_enabled  = each.value.partitioning_enabled

  max_size_in_megabytes             = each.value.max_size_in_megabytes #20480 
  requires_duplicate_detection      = each.value.requires_duplicate_detection #false
  support_ordering                  = each.value.support_ordering #false
}

# Service Bus Subscriptions (dynamically created for each topic)
resource "azurerm_servicebus_subscription" "subscriptions" {
  for_each = {
    for combination in flatten([
      for topic_name, topic_config in var.topics : [
        for sub_name, sub_config in topic_config.subscriptions : {
          key               = "${topic_name}-${sub_name}"
          topic_name        = topic_name
          subscription_name = sub_name
          config            = sub_config
        }
      ]
    ]) : combination.key => combination
  }
  
  name                                  = each.value.subscription_name
  topic_id                              = azurerm_servicebus_topic.topics[each.value.topic_name].id
  max_delivery_count                    = each.value.config.max_delivery_count
  dead_lettering_on_message_expiration  = each.value.config.dead_lettering_on_message_expiration
  
  auto_delete_on_idle                       = "P10675199DT2H48M5.4775807S"
  default_message_ttl                       = "P14D"
  lock_duration                             = "PT1M"
  dead_lettering_on_filter_evaluation_error = each.value.config.dead_lettering_on_filter_evaluation_error #true
  requires_session                          = each.value.config.requires_session #false
}

