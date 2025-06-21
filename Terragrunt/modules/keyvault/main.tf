# import {
#   for_each = toset(var.names)
#   to = azurerm_key_vault.this[each.key]  
#   id = "/subscriptions/8b4ce84d-8f95-4d64-9740-2f565448b5d5/resourceGroups/rg-splg-logsp-common-uat-ger-01/providers/Microsoft.KeyVault/vaults/${each.key}"  
# }

resource "azurerm_key_vault" "this" {
    for_each                            = toset(var.names)
    name                                = each.key
    resource_group_name                 = var.resource_group_name
    location                            = var.location
    tags                                = var.tags
    tenant_id                           = var.tenant_id
    access_policy                   = []
    enable_rbac_authorization       = true
    enabled_for_deployment          = false
    enabled_for_disk_encryption     = false
    enabled_for_template_deployment = false
    purge_protection_enabled        = true
    sku_name                        = "standard"
    soft_delete_retention_days      = 90    
    public_network_access_enabled   = false

    lifecycle {
      ignore_changes = [
        tags,
        access_policy,
        purge_protection_enabled
      ]
    }
}

# Private Endpoint
module "kv_pe" {
  providers = {
    azurerm.connectivity = azurerm.connectivity,
    azurerm              = azurerm
  }
  for_each            = toset(var.names)
  source              = "../../../../../..//dbp-cloud-platform-sharedmodule-iac/networking/private-endpoint" #/dbp-integration-platform-iac/ - germanywestcentral/dev/app-configuration/.terragrunt-cache/jZtRt6XrV4LIcXiSZHaBsE4SBRA/kgBE3M_I3KF6M1oTFk3G9SH3Aug

  name                = var.private_endpoint_name
  resource_group_name = var.resource_group_name_network
  location            = var.location
  subnet = {
    subnet_name         = var.subnet_name
    vnet_name           = var.vnet_name
    resource_group_name = var.resource_group_name_network
  }
  custom_network_interface_name = "${var.private_endpoint_name}-nic"
  private_service_connection = {
    name                           = var.private_endpoint_name
    is_manual_connection           = false
    private_connection_resource_id = azurerm_key_vault.this[each.key].id
    subresource_names              = ["vault"] #https://docs.microsoft.com/en-us/azure/private-link/private-endpoint-overview#private-link-resource
  }
  private_dns_zone_group_name = "default"
  private_dns_zone_names      = ["privatelink.vaultcore.azure.net"]
  private_dns_zone_rg         = "rg-splg-dns-zone-ger-01"

  tags = var.tags
}