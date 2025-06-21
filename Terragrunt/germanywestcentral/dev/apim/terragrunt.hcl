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
 source = "../../../modules/apim"
}

inputs = {
 identity                               = "/subscriptions/f325afb1-2e02-41d8-8c9b-f13102eebe4a/resourceGroups/rg-splg-intgp-common-dev-ger-01/providers/Microsoft.ManagedIdentity/userAssignedIdentities/id-splg-intgp-dev-ger-01"
 identity_type                          = "SystemAssigned, UserAssigned"
 resource_group_name                    = "rg-splg-intgp-common-dev-ger-01"
 resource_group_name_network            = "rg-splg-intgp-network-dev-ger-01"
 location                               = "germanywestcentral"
 network_virtual_network_subnet_id      = "/subscriptions/f325afb1-2e02-41d8-8c9b-f13102eebe4a/resourceGroups/rg-splg-intgp-network-dev-ger-01/providers/Microsoft.Network/virtualNetworks/vnet-splg-intgp-dev-ger-01/subnets/snet-intgp-apim-dev-ger-01"
 network_virtual_network_subnet_id_ext      = "/subscriptions/f325afb1-2e02-41d8-8c9b-f13102eebe4a/resourceGroups/rg-splg-intgp-network-dev-ger-01/providers/Microsoft.Network/virtualNetworks/vnet-splg-intgp-dev-ger-01/subnets/snet-intgp-ext-apim-dev-ger-01"
 names_ext                              = [
  "apim-splg-intgp-dev-ext-ger-01", 
  # "apim-splg-intgp-dev-ext-ger-02"
]
 names_int                              = [
  "apim-splg-intgp-dev-int-ger-01", 
  # "apim-splg-intgp-dev-int-ger-02", 
  # "apim-splg-intgp-dev-int-ger-03"
]
 min_api_version                        = "2021-08-01"
 publisher_email                        = "v_thomas@infinitepl.com"
 publisher_name                         = "SPLG"
 sku_name                               = "Developer_1"
 tags                                   = local.tags
}