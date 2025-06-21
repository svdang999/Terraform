include {
  path = find_in_parent_folders("env_global.hcl")
}

locals {
  # Get Environment name from env_uat.hcl file
  env_config        = read_terragrunt_config(find_in_parent_folders("env_uat.hcl"))
  tenant_id         = local.env_config.locals.tenant_id
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
 source = "../../../modules/keyvault"
}

inputs = {
 resource_group_name                = "rg-splg-intgp-common-uat-ger-01"
 resource_group_name_network        = "rg-splg-intgp-network-uat-ger-01"
 tenant_id                          = "ca4b9986-c729-4ee0-a5be-39c116865241" #SPL Digital
 location                           = "Germany West Central"
 private_endpoint_name              = "pep-splg-intgp-kv-uat-ger-01"
 vnet_name                          = "vnet-splg-intgp-uat-ger-01"
 subnet_name                        = "snet-splg-intgp-pep-uat-ger-01"
 tags                               = local.tags
 names = [
    "kvsplintgpuatger01"
 ]
}
