include {
  # Get global environment variables
  path = find_in_parent_folders("env_global.hcl")
}

locals {
  # Get values from env_dev.hcl file
  env_config          = read_terragrunt_config(find_in_parent_folders("env_dev.hcl"))  
  tags                = local.env_config.locals.tags # can be use as "${local.environment_name}" or local.environment_name
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
          ".*HTTP response was nil; connection may have been reset.*",
          ".*was not found in Active Directory.*",
          ".*http response was nil*.",
          ".*connection may have been reset*."
        ]
        max_attempts = 5                           # Retry up to 5 times
        sleep_interval_sec = 10                    # Wait 10 seconds between retries
    }
}

terraform {
  source = "../../../modules/app-old"
}

inputs = {
  app_service_plan_name             = "asp-splg-intgp-win-dev-ger-01"
  app_service_plan_linux_name       = "asp-splg-intgp-lin-dev-ger-01"
  resource_group_name               = "rg-splg-intgp-common-dev-ger-01"
  resource_group_name_network       = "rg-splg-intgp-network-dev-ger-01"
  location                          = "Germany West Central"
  network_subnet_app                = "snet-intgp-app-dev-ger-01" 
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
  names_linux                         = [
    "func-splg-intgp-zatca-libre-processor-dev-ger-01",
  ]
  names                         = [
    "func-splg-intgp-chatbot-processor-dev-ger-01",
    "func-splg-intgp-chatbot-publisher-dev-ger-01",
    "func-splg-intgp-efaa-processor-dev-ger-01",
    "func-splg-intgp-efaa-publisher-dev-ger-01",
    "func-splg-intgp-gaca-processor-dev-ger-01",
    "func-splg-intgp-gaca-publisher-dev-ger-01",
    "func-splg-intgp-hyper-pay-processor-dev-ger-01",
    "func-splg-intgp-hyper-pay-publisher-dev-ger-01",
    "func-splg-intgp-iq-robotics-processor-dev-ger-01",
    "func-splg-intgp-iq-robotics-publisher-dev-ger-01",
    "func-splg-intgp-mci-processor-dev-ger-01",
    "func-splg-intgp-mci-publisher-dev-ger-01",
    "func-splg-intgp-nic-processor-dev-ger-01",
    "func-splg-intgp-nic-publisher-dev-ger-01",
    "func-splg-intgp-parcel-station-processor-dev-ger-01",
    "func-splg-intgp-parcel-station-publisher-dev-ger-01",
    "func-splg-intgp-pos-processor-dev-ger-01",
    "func-splg-intgp-pos-publisher-dev-ger-01",
    "func-splg-intgp-shorting-processor-dev-ger-01",
    "func-splg-intgp-shorting-publisher-dev-ger-01",
    "func-splg-intgp-smartbox-processor-dev-ger-01",
    "func-splg-intgp-smartbox-publisher-dev-ger-01",
    "func-splg-intgp-state-processor-dev-ger-01",
    "func-splg-intgp-state-publisher-dev-ger-01",
    "func-splg-intgp-tga-processor-dev-ger-01",
    "func-splg-intgp-tga-publisher-dev-ger-01",
    "func-splg-intgp-yamamah-processor-dev-ger-01",
    "func-splg-intgp-yamamah-publisher-dev-ger-01",
    "func-splg-intgp-zatca-publisher-dev-ger-01"
  ]
}