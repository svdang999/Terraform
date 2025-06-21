# import {
#   for_each = toset(var.names)
#   to = azurerm_user_assigned_identity.this[each.key]  
#   id = "/subscriptions/8b4ce84d-8f95-4d64-9740-2f565448b5d5/resourceGroups/rg-splg-logsp-common-uat-ger-01/providers/Microsoft.ManagedIdentity/userAssignedIdentities/${each.key}"  
# }

resource "azurerm_user_assigned_identity" "this" {
  for_each                            = toset(var.names)
  name                                = each.key
  resource_group_name                 = var.resource_group_name
  location                            = var.location
  tags                                = var.tags

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
