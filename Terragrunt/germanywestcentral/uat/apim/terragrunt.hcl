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
 identity                               = "/subscriptions/f325afb1-2e02-41d8-8c9b-f13102eebe4a/resourceGroups/rg-splg-intgp-common-uat-ger-01/providers/Microsoft.ManagedIdentity/userAssignedIdentities/id-splg-intgp-uat-ger-01"
 identity_type                          = "UserAssigned"
 resource_group_name                    = "rg-splg-intgp-common-uat-ger-01"
 resource_group_name_network            = "rg-splg-intgp-network-uat-ger-01"
 location                               = "germanywestcentral"
 network_virtual_network_subnet_id      = "/subscriptions/f325afb1-2e02-41d8-8c9b-f13102eebe4a/resourceGroups/rg-splg-intgp-network-uat-ger-01/providers/Microsoft.Network/virtualNetworks/vnet-splg-intgp-uat-ger-01/subnets/snet-splg-intgp-apim-uat-ger-01"
 network_virtual_network_subnet_id_ext  = "/subscriptions/f325afb1-2e02-41d8-8c9b-f13102eebe4a/resourceGroups/rg-splg-intgp-network-uat-ger-01/providers/Microsoft.Network/virtualNetworks/vnet-splg-intgp-uat-ger-01/subnets/snet-splg-intgp-apim-ext-uat-ger-01"
 names_ext                              = [
  "apim-splg-intgp-uat-ext-ger-01", 
  # "apim-splg-intgp-uat-ext-ger-02"
]
 names_int                              = [
  "apim-splg-intgp-uat-int-ger-01", 
  # "apim-splg-intgp-uat-int-ger-02", 
]
 min_api_version                        = "2021-08-01"
 publisher_email                        = "v-hynh@infinitepl.com"
 publisher_name                         = "SPLG"
 sku_name                               = "Developer_1"
 tags                                   = local.tags
}