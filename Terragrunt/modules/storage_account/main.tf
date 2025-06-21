# import {
#   for_each = toset(var.names)
#   to = azurerm_storage_account.this[each.key]  
#   id = "/subscriptions/8b4ce84d-8f95-4d64-9740-2f565448b5d5/resourceGroups/rg-splg-logsp-common-ppd-ger-01/providers/Microsoft.Storage/storageAccounts/${each.key}"  
# }

resource "azurerm_storage_account" "this" {
  for_each                            = toset(var.names)
  name                                = each.key
  resource_group_name                 = var.resource_group_name
  location                            = var.location
  account_tier                        = "Standard"
  account_replication_type            = var.account_replication_type #"GRS"
  account_kind                        = "StorageV2"
  public_network_access_enabled       = var.public_network_access_enabled
  allow_nested_items_to_be_public     = var.allow_nested_items_to_be_public #true
  tags                                = var.tags

  network_rules {
    default_action             = "Allow"
    bypass                     = ["AzureServices"]
    ip_rules                   = []
    virtual_network_subnet_ids = var.virtual_network_subnet_ids #[]
  }

  lifecycle {
    ignore_changes = [
      tags,
      blob_properties,
      queue_properties,
      routing,
      share_properties,
      static_website,      
      network_rules
    ]
  }
}

