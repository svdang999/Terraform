include {
  path = find_in_parent_folders("env_global.hcl")
}

locals {
  # Get Environment name from env_uat.hcl file
  env_config = read_terragrunt_config(find_in_parent_folders("env_dev.hcl"))
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
 source = "../../../modules/servicebus"
}

inputs = {
 identity                               = "/subscriptions/f325afb1-2e02-41d8-8c9b-f13102eebe4a/resourceGroups/rg-splg-intgp-common-dev-ger-01/providers/Microsoft.ManagedIdentity/userAssignedIdentities/id-splg-intgp-dev-ger-01"
 azuread_administrator_object_id        = "7cf8617d-6f9b-41de-ad1d-71095c9e8e1d" #g-azr-dbp-cloud-admin
 azuread_administrator_login_username   = "g-azr-dbp-cloud-admin"
 resource_group_name                    = "rg-splg-intgp-common-dev-ger-01"
 resource_group_name_network            = "rg-splg-intgp-network-dev-ger-01"
 location                               = "germanywestcentral"
 region_short                           = "ger"
 private_endpoint_name                  = "pep-splg-intgp-servicebus-dev-ger-01"
 private_endpoint_subnet                = "snet-intgp-app-dev-ger-01"
 private_endpoint_vnet                  = "vnet-splg-intgp-dev-ger-01"
 environment                            = local.tags.environment
 platform                               = local.tags.platform
 tags                                   = local.tags
 names_servicebus = [
  "sbns-splg-intgp-dev-ger-01"
 ]

 names_eventhub = [
  "evhns-splg-intgp-dev-ger-01"
 ]
}