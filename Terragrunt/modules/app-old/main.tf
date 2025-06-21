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

data "azurerm_service_plan" "win" {
  name                = var.app_service_plan_name
  resource_group_name = var.resource_group_name
}

data "azurerm_service_plan" "linux" {
  name                = var.app_service_plan_linux_name
  resource_group_name = var.resource_group_name
}

# import {
#   for_each = toset(var.names)
#   to = azurerm_windows_function_app.this[each.key]  
#   id = "/subscriptions/8b4ce84d-8f95-4d64-9740-2f565448b5d5/resourceGroups/rg-splg-logsp-common-ppd-ger-01/providers/Microsoft.Web/sites/${each.key}"  
# }


resource "azurerm_windows_function_app" "this" {
  for_each                                         = toset(var.names)
  name                                             = each.key #"funcapp-splg-${var.platform}-${each.key}-${var.environment}-ger-01"
  location                                         = var.location
  resource_group_name                              = var.resource_group_name
  service_plan_id                                  = data.azurerm_service_plan.win.id
  storage_account_name                             = var.storage_account_name  ## TODO: Create storage account first
  storage_uses_managed_identity                    = true
  public_network_access_enabled                    = var.public_network_access
  virtual_network_subnet_id                        = var.network_virtual_network_subnet_id  ## TODO: Update correct subnet id in terragrunt.hcl each environment
  ftp_publish_basic_authentication_enabled         = false
  webdeploy_publish_basic_authentication_enabled   = false
  https_only = true

  # app_settings = {
  #   WEBSITE_RUN_FROM_PACKAGE = "1"
  #   WEBSITE_CONTENTOVERVNET  = "1"
  #   WEBSITE_DNS_SERVER       = "168.63.129.16"
  # }

  site_config {
    application_stack {
      dotnet_version              = "v8.0"
      use_dotnet_isolated_runtime = true
    }    
  }

  identity {
    type = "UserAssigned"
    identity_ids = [
      var.identity      
    ]
  }

  tags = var.tags
  lifecycle {
    ignore_changes = [
      site_config,
      app_settings,
      auth_settings_v2,
      sticky_settings,
      identity,
      ftp_publish_basic_authentication_enabled,
      webdeploy_publish_basic_authentication_enabled,
      storage_account_access_key,
      storage_uses_managed_identity,
      builtin_logging_enabled,
      client_certificate_mode,
      virtual_network_subnet_id,
      tags
    ]
  }
}


resource "azurerm_linux_function_app" "this" {
  for_each                                         = toset(var.names_linux)
  name                                             = each.key
  location                                         = var.location
  resource_group_name                              = var.resource_group_name

  storage_account_name                             = var.storage_account_name
  storage_uses_managed_identity                    = true
  service_plan_id                                  = data.azurerm_service_plan.linux.id
  https_only                                       = true
  public_network_access_enabled                    = false

  site_config {}

  lifecycle {
    ignore_changes = [
      site_config,
      app_settings,
      sticky_settings,
      identity,
      ftp_publish_basic_authentication_enabled,
      webdeploy_publish_basic_authentication_enabled,
      storage_account_access_key,
      storage_uses_managed_identity,
      storage_account,
      builtin_logging_enabled,
      virtual_network_subnet_id,
      client_certificate_mode,
      tags
    ]
  }
}


# Private Endpoints
# module "func_pe" {
#   providers = {
#     azurerm.connectivity = azurerm.connectivity,
#     azurerm              = azurerm
#   }
#   for_each            = toset(var.names)
#   source              = "git::ssh://git@github.com/SaudiPostLogisticsGroup/dbp-cloud-platform-sharedmodule-iac.git//networking/private-endpoint?ref=main"

#   name                = "pep-splg-${var.platform}-${each.key}-func-${var.environment}-ger-01"
#   resource_group_name = var.resource_group_name_network
#   location            = var.location
#   subnet = {
#     subnet_name         = var.network_subnet_app
#     vnet_name           = var.network_vnet_name
#     resource_group_name = var.resource_group_name_network
#   }
#   custom_network_interface_name = "pep-splg-${var.platform}-${each.key}-func-${var.environment}-ger-01-nic"
#   private_service_connection = {
#     name                           = "pep-splg-${var.platform}-${each.key}-func-${var.environment}-ger-01"
#     is_manual_connection           = false
#     private_connection_resource_id = azurerm_windows_function_app.this[each.key].id
#     subresource_names              = ["sites"] #https://docs.microsoft.com/en-us/azure/private-link/private-endpoint-overview#private-link-resource
#   }
#   private_dns_zone_group_name = "default"
#   private_dns_zone_names      = ["privatelink.azurewebsites.net"]
#   private_dns_zone_rg         = "rg-splg-dns-zone-ger-01"

#   tags = var.tags
# }
