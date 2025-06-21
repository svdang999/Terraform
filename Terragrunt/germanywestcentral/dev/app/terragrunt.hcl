include {
  # Get global environment variables
  path = find_in_parent_folders("env_global.hcl")
}

locals {
  # Get values from env_dev.hcl file
  env_config          = read_terragrunt_config(find_in_parent_folders("env_dev.hcl"))  
  tags                = local.env_config.locals.tags # can be use as "${local.environment_name}" or local.environment_name

  # Windows Function App configuration with conditional private endpoints
  names = {
    func-splg-intgp-notification-processor-dev-ger-01 = {
      enable_private_endpoint = true
    }
    func-splg-intgp-notification-publisher-dev-ger-01 = {
      enable_private_endpoint = true
    }
    func-splg-intgp-nearpay-processor-dev-ger-01 = {
      enable_private_endpoint = true
    }
    func-splg-intgp-nearpay-publisher-dev-ger-01 = {
      enable_private_endpoint = true
    }
    thomas-ver01 = {
      enable_private_endpoint = true
    }
  }
}

# https://terragrunt.gruntwork.io/docs/reference/config-blocks-and-attributes/#retry-configuration
errors {
    retry "azure_errors" {
        retryable_errors = [
          ".*Failed to load state.*",
          ".*Failed to download module.*",
          ".*Failed to query available provider packages.*",
          ".*Error: retrieving account keys for storage account.*",
          ".*Error: getting Storage Account Properties.*",
          ".*could not obtain lease.*",
          ".*socket: connection reset by peer.*",
          ".*HTTP status 429.*",  # Too Many Requests
          ".*network connection reset by peer.*",
          ".*connection refused.*",
          ".*TLS handshake timeout.*",
          ".*ServiceUnavailable.*",
          ".*InternalServerError.*",
          ".*was not found in Active Directory.*",
          ".*http response was nil*.",
          ".*connection may have been reset*."
        ]
        max_attempts = 5                           # Retry up to 5 times
        sleep_interval_sec = 10                    # Wait 10 seconds between retries
    }
}

terraform {
  source = "../../../modules/app"
}

inputs = {
  app_service_plan_name             = "asp-splg-intgp-win-dev-ger-01"
  app_service_plan_name_linux       = "asp-splg-intgp-lin-dev-ger-01"
  resource_group_name               = "rg-splg-intgp-common-dev-ger-01"
  resource_group_name_network       = "rg-splg-intgp-network-dev-ger-01"
  location                          = "Germany West Central"
  network_subnet_app                = "snet-intgp-db-dev-ger-01" 
  network_vnet_name                 = "vnet-splg-intgp-dev-ger-01"
  network_virtual_network_subnet_id = "/subscriptions/f325afb1-2e02-41d8-8c9b-f13102eebe4a/resourceGroups/rg-splg-intgp-network-dev-ger-01/providers/Microsoft.Network/virtualNetworks/vnet-splg-intgp-dev-ger-01/subnets/snet-intgp-func-dev-ger-01"
  environment                       = "dev"
  platform                          = "intgp"
  public_network_access             = false
  sku_name                          = "P1v2" #Premium v2 - VNET Integration
  storage_account_name              = "stsplgintgpdevger01"
  identity                          = "/subscriptions/f325afb1-2e02-41d8-8c9b-f13102eebe4a/resourceGroups/rg-splg-intgp-common-dev-ger-01/providers/Microsoft.ManagedIdentity/userAssignedIdentities/id-splg-intgp-dev-ger-01"  
  logs_destinations_id              = "/subscriptions/f325afb1-2e02-41d8-8c9b-f13102eebe4a/resourceGroups/DefaultResourceGroup-DEWC/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-f325afb1-2e02-41d8-8c9b-f13102eebe4a-DEWC"
  tags                              = local.tags
  # names_linux                         = [
  #   "func-splg-intgp-zatca-libre-processor-dev-ger-01",
  # ]

  names = local.names # Windows Function Apps 

  # names                         = [
  #   "func-splg-intgp-notification-processor-dev-ger-01",
  #   "func-splg-intgp-notification-publisher-dev-ger-01",
  #   "func-splg-intgp-nearpay-processor-dev-ger-01",
  #   "func-splg-intgp-nearpay-publisher-dev-ger-01"
  # ]
}
