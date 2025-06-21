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

# terraform {
#  source = "../../../modules/networks"
# }

# inputs = {
#   resource_group_name                     = "rg-splg-intgp-common-uat-ger-01"
#   resource_group_name_network             = "rg-splg-intgp-network-uat-ger-01"
#   location                                = "germanywestcentral"
#   # name_nsg                                = "nsg-terragrunt-test01-ger-01"
#   names                                   = [
#     "nsg-terragrunt-test-uat-ger-01",
#     # "nsg-terragrunt-test-uat-ger-02",
#   ]
#   network_virtual_network_subnet_id       = "/subscriptions/f325afb1-2e02-41d8-8c9b-f13102eebe4a/resourceGroups/rg-splg-intgp-network-uat-ger-01/providers/Microsoft.Network/virtualNetworks/vnet-splg-intgp-uat-ger-01/subnets/snet-splg-intgp-pep-uat-ger-01"
#   tags                                     = local.tags
# }