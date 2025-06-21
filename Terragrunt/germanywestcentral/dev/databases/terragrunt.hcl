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
 source = "../../../modules/databases-old"
}

inputs = {
 db_identity                            = "/subscriptions/f325afb1-2e02-41d8-8c9b-f13102eebe4a/resourceGroups/rg-splg-intgp-common-dev-ger-01/providers/Microsoft.ManagedIdentity/userAssignedIdentities/id-splg-intgp-dev-ger-01"
 identity_type                          = "SystemAssigned, UserAssigned"
 azuread_administrator_object_id        = "7cf8617d-6f9b-41de-ad1d-71095c9e8e1d" #g-azr-dbp-cloud-admin
 azuread_administrator_login_username   = "g-azr-dbp-cloud-admin"
 resource_group_name                    = "rg-splg-intgp-common-dev-ger-01"
 resource_group_name_network            = "rg-splg-intgp-network-dev-ger-01"
 location                               = "germanywestcentral"
 private_endpoint_name                  = "pep-splg-intgp-sql-dev-ger-01"
 private_endpoint_subnet                = "snet-intgp-db-dev-ger-01"
 private_endpoint_vnet                  = "vnet-splg-intgp-dev-ger-01"
 sql_server_name_elasticpool            = "sqlep-splg-intgp-dev-ger-01"
 sql_server_name                        = "sql-splg-intgp-dev-ger-01"
 tags                                   = local.tags
 cosmosdb_public_network_access_enabled = false
 cosmosdb_automatic_failover_enabled    = true
 cosmosdb_is_virtual_network_filter_enabled = true
 redis_public_network_access_enabled    = true
 redis_capacity                         = 0
 names_server = [
    "sql-splg-intgp-dev-ger-01"
 ]
 names_server_redis = [
    "redis-splg-intgp-dev-ger-01"
 ]
 names_server_cosmosdb = [
    "cosmos-splg-intgp-dev-ger-01"
 ]
}

