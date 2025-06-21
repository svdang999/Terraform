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
 source = "../../../modules/keyvault"
}

inputs = {
 resource_group_name                = "rg-splg-intgp-common-dev-ger-01"
 resource_group_name_network        = "rg-splg-intgp-network-dev-ger-01"
 tenant_id                          = "ca4b9986-c729-4ee0-a5be-39c116865241" #SPL Digital
 location                           = "Germany West Central"
 private_endpoint_name              = "pep-splg-intgp-kv-dev-ger-01-testtt"
 vnet_name                          = "vnet-splg-intgp-dev-ger-01"
 subnet_name                        = "snet-intgp-db-dev-ger-01"
 tags                               = local.tags
 names = [
    "kvsplintgpnprdger01"
 ]
}
