include {
  path = find_in_parent_folders("env_global.hcl")
}

locals {
  # Get Environment name from env_uat.hcl file
  env_config = read_terragrunt_config(find_in_parent_folders("env_uat.hcl"))
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
          ".*was not found in Active Directory.*"
        ]
        max_attempts = 5                           # Retry up to 5 times
        sleep_interval_sec = 10                    # Wait 10 seconds between retries
    }
}

terraform {
 source = "../../../modules/app-configuration"
}

inputs = {
  identity                               = "/subscriptions/f325afb1-2e02-41d8-8c9b-f13102eebe4a/resourceGroups/rg-splg-intgp-common-uat-ger-01/providers/Microsoft.ManagedIdentity/userAssignedIdentities/id-splg-intgp-uat-ger-01"
  azuread_administrator_object_id        = "7cf8617d-6f9b-41de-ad1d-71095c9e8e1d" #g-azr-dbp-cloud-admin
  azuread_administrator_login_username   = "g-azr-dbp-cloud-admin"
  resource_group_name                    = "rg-splg-intgp-common-uat-ger-01"
  resource_group_name_network            = "rg-splg-intgp-network-uat-ger-01"
  location                               = "germanywestcentral"
  private_endpoint_subnet                = "snet-splg-intgp-app-uat-ger-01"
  private_endpoint_vnet                  = "vnet-splg-intgp-uat-ger-01"
  public_network_access                  = "Disabled"
  environment                            = local.tags.environment
  platform                               = local.tags.platform
  tags                                   = local.tags
  names                                  = [
    "acfg-splg-intgp-notification-hub-uat-ger-01",
    "acfg-splg-intgp-nearpay-uat-ger-01",
    "acfg-splg-intgp-gaca-uat-ger-01",
    "acfg-splg-intgp-hyper-pay-uat-ger-01",
    "acfg-splg-intgp-mci-uat-ger-01",
    "acfg-splg-intgp-nic-uat-ger-01",
    "acfg-splg-intgp-parcel-station-uat-ger-01",
    "acfg-splg-intgp-robotics-uat-ger-01",
    "acfg-splg-intgp-shorting-uat-ger-01",
    "acfg-splg-intgp-smartbox-uat-ger-01",
    "acfg-splg-intgp-state-security-uat-ger-01",
    "acfg-splg-intgp-tga-uat-ger-01",
    "acfg-splg-intgp-yamamah-uat-ger-01",
    "acfg-splg-intgp-zatca-uat-ger-01",
    "acfg-splg-intgp-efaa-uat-ger-01",
    "acfg-splg-intgp-chatbot-uat-ger-01",   
    "acfg-splg-intgp-pos-uat-ger-01"
  ]
}