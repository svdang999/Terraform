# import {
#   for_each = toset(var.names_servicebus)
#   to = azurerm_servicebus_namespace.this[each.key]  
#   id = "/subscriptions/8b4ce84d-8f95-4d64-9740-2f565448b5d5/resourceGroups/rg-splg-logsp-common-ppd-ger-01/providers/Microsoft.ServiceBus/namespaces/${each.key}"  
# }

resource "azurerm_servicebus_namespace" "this" {
    for_each                            = toset(var.names_servicebus)
    name                                = each.key
    capacity                            = 0    
    local_auth_enabled                  = true
    location                            = var.location
    minimum_tls_version                 = "1.2"
    premium_messaging_partitions        = 0
    public_network_access_enabled       = true
    resource_group_name                 = var.resource_group_name
    sku                                 = "Standard"
    tags                                = var.tags

    network_rule_set {
        default_action                = "Allow"
        ip_rules                      = []
        public_network_access_enabled = true
        trusted_services_allowed      = false
    }
    lifecycle {
      ignore_changes = [
        tags,
        network_rule_set
      ]
    }
}

## Topics
resource "azurerm_servicebus_topic" "this" {
  for_each                            = toset(var.names_servicebus)
  name                                = each.key
  namespace_id                        = azurerm_servicebus_namespace.this[each.key].id
  partitioning_enabled                = true
}

## Subscriptions
# resource "azurerm_servicebus_subscription" "this" {
#   for_each                            = toset(var.names_servicebus)
#   name                                = "sub-${each.value.topic}"
#   topic_id                            = azurerm_servicebus_topic.this[each.value.topic].id
#   max_delivery_count                  = 1
# }

resource "azurerm_eventhub_namespace" "this" {
    for_each                                    = toset(var.names_eventhub)
    name                                        = each.key
    auto_inflate_enabled                      = false
    capacity                                  = 1
    dedicated_cluster_id                      = null
    local_authentication_enabled              = true
    location                                  = var.location
    maximum_throughput_units                  = 0
    minimum_tls_version                       = "1.2"
    network_rulesets                          = [
        {
            default_action                 = "Allow"
            ip_rule                        = []
            public_network_access_enabled  = true
            trusted_service_access_enabled = false
            virtual_network_rule           = []
        },
    ]
    public_network_access_enabled             = true
    resource_group_name                       = var.resource_group_name
    sku                                       = "Standard"
    tags                                      = var.tags

    lifecycle {
      ignore_changes = [
        tags,
      ]
    }
}