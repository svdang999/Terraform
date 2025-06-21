# data "azurerm_log_analytics_workspace" "npd" {
#   provider            = azurerm.management
#   name                = "log-splg-intgp-dev-ger-01"
#   resource_group_name = "rg-splg-cloudp-app-log-mgt-npd-ger-01"
# }

data "azurerm_application_insights" "npd" {
  provider            = azurerm.management
  name                = "appi-splg-intgp-dev-ger-01"
  resource_group_name = "rg-splg-cloudp-app-log-mgt-npd-ger-01"
}

# resource "azurerm_service_plan" "win" {
#   name                                = var.app_service_plan_name
#   resource_group_name                 = var.resource_group_name
#   location                            = var.location
#   os_type                             = "Windows"
#   sku_name                            = var.sku_name #"F1" #Free 
#   tags = var.tags
#   lifecycle {
#     ignore_changes = [
#       tags["create_date"]
#     ]
#   }
# }

data "azurerm_service_plan" "linux" {
  name                = var.app_service_plan_name_linux
  resource_group_name = var.resource_group_name
}

data "azurerm_service_plan" "win" {
  name                = var.app_service_plan_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_windows_function_app" "this" {
  for_each                                         = tomap(var.names)
  name                                             = each.key
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
    application_insights_connection_string = data.azurerm_application_insights.npd.connection_string
    application_insights_key               = data.azurerm_application_insights.npd.instrumentation_key
    ip_restriction_default_action          = "Deny"
    ftps_state                             = "FtpsOnly"
    vnet_route_all_enabled                 = true
    use_32_bit_worker                      = false
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
      sticky_settings,
      ftp_publish_basic_authentication_enabled,
      webdeploy_publish_basic_authentication_enabled,
      auth_settings_v2,
      tags["create_date"]
    ]
  }
}

# Private Endpoints
module "func_pe" {
  providers = {
    azurerm.connectivity = azurerm.connectivity,
    azurerm              = azurerm
  }
  # for_each            = toset(var.names)
  # Only create private endpoints for apps where enable_private_endpoint = true
  for_each = {
    for name, config in var.names : name => config
    if lookup(config, "enable_private_endpoint", false) == true
  }

  # source              = "git::ssh://git@github.com/SaudiPostLogisticsGroup/dbp-cloud-platform-sharedmodule-iac.git//networking/private-endpoint?ref=main"
  source              = "../../../../../..//dbp-cloud-platform-sharedmodule-iac/networking/private-endpoint" #/dbp-integration-platform-iac/ - germanywestcentral/dev/app-configuration/.terragrunt-cache/jZtRt6XrV4LIcXiSZHaBsE4SBRA/kgBE3M_I3KF6M1oTFk3G9SH3Aug

  name                = "pep-${each.key}"
  resource_group_name = var.resource_group_name_network
  location            = var.location
  subnet = {
    subnet_name         = var.network_subnet_app
    vnet_name           = var.network_vnet_name
    resource_group_name = var.resource_group_name_network
  }
  custom_network_interface_name = "pep-${each.key}"
  private_service_connection = {
    name                           = "pep-${each.key}"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_windows_function_app.this[each.key].id
    subresource_names              = ["sites"] #https://docs.microsoft.com/en-us/azure/private-link/private-endpoint-overview#private-link-resource
  }
  private_dns_zone_group_name = "default"
  private_dns_zone_names      = ["privatelink.azurewebsites.net"]
  private_dns_zone_rg         = "rg-splg-dns-zone-ger-01"

  tags = var.tags
}


# Linux
resource "azurerm_linux_function_app" "this" {
  for_each                                          = toset(var.names_linux)
  name                                              = each.key
  location                                          = var.location
  resource_group_name                               = var.resource_group_name
  storage_account_name                              = var.storage_account_name
  service_plan_id                                   = data.azurerm_service_plan.linux.id
  public_network_access_enabled                     = var.public_network_access
  virtual_network_subnet_id                         = var.network_virtual_network_subnet_id
  storage_uses_managed_identity                     = true
  https_only                                        = true
  app_settings = {
    WEBSITE_RUN_FROM_PACKAGE = 1
    FUNCTIONS_WORKER_RUNTIME = "dotnet-isolated"
  }

  tags = var.tags

  site_config {}

  identity {
    type = "UserAssigned"
    identity_ids = [
      var.identity      
    ]
  }

  lifecycle {
    ignore_changes = [
      site_config,
      # app_settings,
      sticky_settings,
      ftp_publish_basic_authentication_enabled,
      webdeploy_publish_basic_authentication_enabled,
      storage_account_access_key,
      storage_account,
      builtin_logging_enabled,
      client_certificate_mode,
      tags["create_date"]
    ]
  }
}

module "func_pe_linux" {
  providers = {
    azurerm.connectivity = azurerm.connectivity,
    azurerm              = azurerm
  }
  for_each            = toset(var.names_linux)
  # source              = "git::ssh://git@github.com/SaudiPostLogisticsGroup/dbp-cloud-platform-sharedmodule-iac.git//networking/private-endpoint?ref=main"
  source              = "../../../../../..//dbp-cloud-platform-sharedmodule-iac/networking/private-endpoint" #/dbp-integration-platform-iac/ - germanywestcentral/dev/app-configuration/.terragrunt-cache/jZtRt6XrV4LIcXiSZHaBsE4SBRA/kgBE3M_I3KF6M1oTFk3G9SH3Aug

  name                = "pep-${each.key}"
  resource_group_name = var.resource_group_name_network
  location            = var.location
  subnet = {
    subnet_name         = var.network_subnet_app
    vnet_name           = var.network_vnet_name
    resource_group_name = var.resource_group_name_network
  }
  custom_network_interface_name = "pep-${each.key}"
  private_service_connection = {
    name                           = "pep-${each.key}"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_linux_function_app.this[each.key].id
    subresource_names              = ["sites"] #https://docs.microsoft.com/en-us/azure/private-link/private-endpoint-overview#private-link-resource
  }
  private_dns_zone_group_name = "default"
  private_dns_zone_names      = ["privatelink.azurewebsites.net"]
  private_dns_zone_rg         = "rg-splg-dns-zone-ger-01"

  tags = var.tags
}

# Diagnostics logs
#module "func_diag" {
#  for_each = toset(var.names)
#  source  = "git::ssh://git@github.com/SaudiPostLogisticsGroup/dbp-cloud-platform-sharedmodule-iac.git//monitor/diagnostic-setting?ref=main"
#
#  name    = "diag-func-splg-${var.platform}-${each.key}-${var.environment}-ger-01"
#  resource_id = azurerm_windows_function_app.this[each.key].id
#  log_categories = [
#    "FunctionAppLogs",
#    "AppServiceAuthenticationLogs",
#  ]
#  metric_categories = [
#    "AllMetrics"
#  ]
#  logs_destinations_ids = [
#    var.logs_destinations_id
#  ]
#}