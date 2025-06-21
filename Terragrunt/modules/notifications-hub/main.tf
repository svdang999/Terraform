resource "azurerm_notification_hub_namespace" "this" {
  name                = var.name_namespace_notification_hub
  resource_group_name = var.resource_group_name 
  location            = var.location 
  namespace_type      = var.namespace_type 

  sku_name = var.sku_name 
}

resource "azurerm_notification_hub" "this" {
  name                = var.name_notification_hub
  namespace_name      = azurerm_notification_hub_namespace.this.name
  resource_group_name = var.resource_group_name 
  location            = var.location 
}

resource "azurerm_notification_hub_authorization_rule" "this" {
  name                  = var.name_notification_hub_authorization_rule
  notification_hub_name = azurerm_notification_hub.this.name
  namespace_name        = azurerm_notification_hub_namespace.this.name
  resource_group_name   = var.resource_group_name 
  manage                = var.notification_hub_authorization_rule_manage #true
  send                  = var.notification_hub_authorization_rule_send #true
  listen                = var.notification_hub_authorization_rule_listen #true
}