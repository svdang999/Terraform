include {
  path = find_in_parent_folders("env_global.hcl")
}

locals {
  # Get values from env_uat.hcl file
  env_config        = read_terragrunt_config(find_in_parent_folders("env_uat.hcl"))
  tags              = local.env_config.locals.tags
}

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
  app_service_plan_name             = "asp-splg-intgp-win-uat-ger-01" #Premium v2 - VNET Integration
  app_service_plan_name_linux       = "asp-splg-intgp-lin-uat-ger-01"
  resource_group_name               = "rg-splg-intgp-common-uat-ger-01"
  resource_group_name_network       = "rg-splg-intgp-network-uat-ger-01"
  location                          = "Germany West Central"
  network_subnet_app                = "snet-splg-intgp-app-uat-ger-01" 
  network_vnet_name                 = "vnet-splg-intgp-uat-ger-01"
  network_virtual_network_subnet_id = "/subscriptions/f325afb1-2e02-41d8-8c9b-f13102eebe4a/resourceGroups/rg-splg-intgp-network-uat-ger-01/providers/Microsoft.Network/virtualNetworks/vnet-splg-intgp-uat-ger-01/subnets/snet-splg-intgp-func-uat-ger-01"
  environment                       = "uat"
  platform                          = "intgp"
  public_network_access             = false
  storage_account_name              = "stsplgintgpuatger01"
  identity                          = "/subscriptions/f325afb1-2e02-41d8-8c9b-f13102eebe4a/resourceGroups/rg-splg-intgp-common-uat-ger-01/providers/Microsoft.ManagedIdentity/userAssignedIdentities/id-splg-intgp-uat-ger-01"  
  logs_destinations_id              = "/subscriptions/f325afb1-2e02-41d8-8c9b-f13102eebe4a/resourceGroups/DefaultResourceGroup-DEWC/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-f325afb1-2e02-41d8-8c9b-f13102eebe4a-DEWC"
  tags                              = local.tags
  names_linux                         = [
    "func-splg-intgp-zatca-libre-processor-uat-ger-01",
  ]
  names                         = [
    "func-splg-intgp-notification-processor-uat-ger-01",
    "func-splg-intgp-notification-publisher-uat-ger-01",
    "func-splg-intgp-nearpay-processor-uat-ger-01",
    "func-splg-intgp-nearpay-publisher-uat-ger-01",
    "func-splg-intgp-chatbot-processor-uat-ger-01",
    "func-splg-intgp-chatbot-publisher-uat-ger-01",
    "func-splg-intgp-efaa-processor-uat-ger-01",
    "func-splg-intgp-efaa-publisher-uat-ger-01",
    "func-splg-intgp-gaca-processor-uat-ger-01",
    "func-splg-intgp-gaca-publisher-uat-ger-01",
    "func-splg-intgp-hyper-pay-processor-uat-ger-01",
    "func-splg-intgp-hyper-pay-publisher-uat-ger-01",
    "func-splg-intgp-iq-robotics-processor-uat-ger-01",
    "func-splg-intgp-iq-robotics-publisher-uat-ger-01",
    "func-splg-intgp-mci-processor-uat-ger-01",
    "func-splg-intgp-mci-publisher-uat-ger-01",
    "func-splg-intgp-nic-processor-uat-ger-01",
    "func-splg-intgp-nic-publisher-uat-ger-01",
    "func-splg-intgp-parcel-station-processor-uat-ger-01",
    "func-splg-intgp-parcel-station-publisher-uat-ger-01",
    "func-splg-intgp-pos-processor-uat-ger-01",
    "func-splg-intgp-pos-publisher-uat-ger-01",
    "func-splg-intgp-shorting-processor-uat-ger-01",
    "func-splg-intgp-shorting-publisher-uat-ger-01",
    "func-splg-intgp-smartbox-processor-uat-ger-01",
    "func-splg-intgp-smartbox-publisher-uat-ger-01",
    "func-splg-intgp-state-processor-uat-ger-01",
    "func-splg-intgp-state-publisher-uat-ger-01",
    "func-splg-intgp-tga-processor-uat-ger-01",
    "func-splg-intgp-tga-publisher-uat-ger-01",
    "func-splg-intgp-yamamah-processor-uat-ger-01",
    "func-splg-intgp-yamamah-publisher-uat-ger-01",
    "func-splg-intgp-zatca-publisher-uat-ger-01"
  ]
}