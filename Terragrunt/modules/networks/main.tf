#NSG
# resource "azurerm_network_security_group" "this" {
#     for_each                        = toset(var.names)
#     name                            = each.key
#     resource_group_name             = var.resource_group_name_network
#     location                        = var.location
# }

# resource "azurerm_subnet_network_security_group_association" "this" {
#     for_each                        = toset(var.names)
#     subnet_id                       = var.network_virtual_network_subnet_id
#     network_security_group_id       = azurerm_network_security_group.this[each.key].id
# }

# import {
#   for_each      = toset(var.names_vnet)
#   to            = azurerm_virtual_network.this[each.key]  
#   id            = "/subscriptions/8b4ce84d-8f95-4d64-9740-2f565448b5d5/resourceGroups/rg-splg-logsp-network-dev-ger-01/providers/Microsoft.Network/virtualNetworks/${each.key}"  
# }

resource "azurerm_virtual_network" "this" {
    for_each                                    = toset(var.names_vnet)
    name                                        = each.key
    address_space                               = var.vnet_address_space 
    location                                    = var.location
    resource_group_name                         = var.resource_group_name_network
    lifecycle {
      ignore_changes = [
        tags,
        encryption
      ]
    }
}


# import {
#   for_each      = var.names_subnet
#   to            = azurerm_subnet.this[each.key]  
#   id            = "/subscriptions/8b4ce84d-8f95-4d64-9740-2f565448b5d5/resourceGroups/rg-splg-logsp-network-uat-ger-01/providers/Microsoft.Network/virtualNetworks/vnet-splg-logsp-uat-ger-01/subnets/${each.key}"  
# }

# resource "azurerm_subnet" "this" {
#     for_each                = var.names_subnet
#     name                    = each.key
#     resource_group_name     = var.resource_group_name_network
#     virtual_network_name    = azurerm_virtual_network.this[each.value].name
#     address_prefixes        = var.subnet_address_prefixes #["10.0.1.0/24"]

#     delegation {
#         name = var.delegation #"delegation"
#         service_delegation {
#             name    = var.subnet_service_delegation_name #"Microsoft.ContainerInstance/containerGroups"
#             actions = var.subnet_service_delegation_action #["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
#         }
#     }
# }