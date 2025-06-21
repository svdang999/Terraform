include {
  path = find_in_parent_folders("env_global.hcl")
}

locals {
  # Get values from env_dev.hcl file
  env_config          = read_terragrunt_config(find_in_parent_folders("env_dev.hcl"))  
  tags                = local.env_config.locals.tags # can be use as "${local.tags}" or local.tags
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
 source = "../../../modules/storage_account"
}

inputs = {
 resource_group_name        = "rg-splg-intgp-common-dev-ger-01"
 location                   = "Germany West Central"
 tags                       = local.tags
 names                      = [
    "stsplgintgpdevger01"
 ]

 virtual_network_subnet_ids = [
    "/subscriptions/f325afb1-2e02-41d8-8c9b-f13102eebe4a/resourceGroups/rg-splg-intgp-network-dev-ger-01/providers/Microsoft.Network/virtualNetworks/vnet-splg-intgp-dev-ger-01/subnets/snet-intgp-apim-dev-ger-01",
    "/subscriptions/f325afb1-2e02-41d8-8c9b-f13102eebe4a/resourceGroups/rg-splg-intgp-network-dev-ger-01/providers/Microsoft.Network/virtualNetworks/vnet-splg-intgp-dev-ger-01/subnets/snet-intgp-app-dev-ger-01",
    "/subscriptions/f325afb1-2e02-41d8-8c9b-f13102eebe4a/resourceGroups/rg-splg-intgp-network-dev-ger-01/providers/Microsoft.Network/virtualNetworks/vnet-splg-intgp-dev-ger-01/subnets/snet-intgp-db-dev-ger-01",
    "/subscriptions/f325afb1-2e02-41d8-8c9b-f13102eebe4a/resourceGroups/rg-splg-intgp-network-dev-ger-01/providers/Microsoft.Network/virtualNetworks/vnet-splg-intgp-dev-ger-01/subnets/snet-intgp-func-dev-ger-01"
 ]
}