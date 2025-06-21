# import {
#   for_each      = toset(var.names_int)
#   to            = azurerm_api_management.int[each.key]  
#   id            = "/subscriptions/f325afb1-2e02-41d8-8c9b-f13102eebe4a/resourceGroups/rg-splg-intgp-common-dev-ger-01/providers/Microsoft.ApiManagement/service/${each.key}"  
# }

# import {
#   for_each      = toset(var.names_ext)
#   to            = azurerm_api_management.ext[each.key]  
#   id            = "/subscriptions/f325afb1-2e02-41d8-8c9b-f13102eebe4a/resourceGroups/rg-splg-intgp-common-dev-ger-01/providers/Microsoft.ApiManagement/service/${each.key}"  
# }

## External APIM
resource "azurerm_api_management" "ext" {
  for_each                              = toset(var.names_ext)
  name                                  = each.key
  min_api_version                       = var.min_api_version 
  publisher_email                       = var.publisher_email
  publisher_name                        = var.publisher_name 
  resource_group_name                   = var.resource_group_name
  location                              = var.location
  tags                                  = var.tags
  sku_name                              = var.sku_name
  virtual_network_type                  = "Internal"

  identity {
      type = var.identity_type
      identity_ids = [
          var.identity      
      ]
  }

  virtual_network_configuration {
    subnet_id = var.network_virtual_network_subnet_id_ext
  }

  lifecycle {
    ignore_changes = [  
      tags,
    ]
  }
}

## Internal APIM
resource "azurerm_api_management" "int" {
  for_each                              = toset(var.names_int)
  name                                  = each.key
  min_api_version                       = var.min_api_version 
  publisher_email                       = var.publisher_email
  publisher_name                        = var.publisher_name 
  resource_group_name                   = var.resource_group_name
  location                              = var.location
  tags                                  = var.tags
  sku_name                              = var.sku_name
  virtual_network_type                  = "Internal"
  identity {
      type = var.identity_type #"SystemAssigned, UserAssigned"
      identity_ids = [
          var.identity      
      ]
  }

  virtual_network_configuration {
    subnet_id = var.network_virtual_network_subnet_id
  }

  lifecycle {
    ignore_changes = [  
      tags,
      certificate
    ]
  }
}
