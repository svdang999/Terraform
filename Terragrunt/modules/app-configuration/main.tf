# data "azurerm_log_analytics_workspace" "npd" {
#   provider            = azurerm.management
#   name                = "log-splg-intgp-dev-ger-01"
#   resource_group_name = "rg-splg-cloudp-app-log-mgt-npd-ger-01"
# }

# data "azurerm_application_insights" "npd" {
#   provider            = azurerm.management
#   name                = "appi-splg-intgp-dev-ger-01"
#   resource_group_name = "rg-splg-cloudp-app-log-mgt-npd-ger-01"
# }

resource "azurerm_app_configuration" "this" {
  for_each                      = toset(var.names)
  name                          = each.key #"appcs-splg-${var.platform}-${each.key}-acfg-${var.environment}-ger-01"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  sku                           = var.sku
  public_network_access         = var.public_network_access

  identity {
    type = "UserAssigned"
    identity_ids = [
      var.identity
    ]
  }

  soft_delete_retention_days = var.soft_delete_retention_days #7
  purge_protection_enabled = var.purge_protection_enabled #false
  tags = var.tags

  lifecycle {
    ignore_changes = [  
      tags,
      # identity,
      data_plane_proxy_authentication_mode
    ]
  }
}


module "app_pe" {
  providers = {
    azurerm.connectivity = azurerm.connectivity,
    azurerm              = azurerm
  }
  for_each            = toset(var.names)

  # source              = "git::ssh://git@github.com/SaudiPostLogisticsGroup/dbp-cloud-platform-sharedmodule-iac.git//networking/private-endpoint?ref=main"
  source              = "../../../../../..//dbp-cloud-platform-sharedmodule-iac/networking/private-endpoint" ##/dbp-integration-platform-iac/ - germanywestcentral/dev/app-configuration/.terragrunt-cache/jZtRt6XrV4LIcXiSZHaBsE4SBRA/kgBE3M_I3KF6M1oTFk3G9SH3Aug
  
  name                = "pep-${each.key}"
  resource_group_name = var.resource_group_name_network
  location            = var.location
  subnet = {
    subnet_name         = var.private_endpoint_subnet
    vnet_name           = var.private_endpoint_vnet
    resource_group_name = var.resource_group_name_network
  }
  custom_network_interface_name = "pep-${each.key}-nic"
  private_service_connection = {
    name                           = "pep-${each.key}"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_app_configuration.this[each.key].id
    subresource_names              = ["configurationStores"] #https://docs.microsoft.com/en-us/azure/private-link/private-endpoint-overview#private-link-resource
  }
  private_dns_zone_group_name = "default"
  private_dns_zone_names      = ["privatelink.azconfig.io"]
  private_dns_zone_rg         = "rg-splg-dns-zone-ger-01"

  tags = var.tags
}