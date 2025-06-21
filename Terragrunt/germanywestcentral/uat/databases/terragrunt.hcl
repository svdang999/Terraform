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
 source = "../../../modules/databases"
}

inputs = {
  resource_group_name                   = "rg-splg-intgp-common-uat-ger-01"
  location                              = "germanywestcentral"
  tags                                  = local.tags

  # Identity 
  tenant_id    = "ca4b9986-c729-4ee0-a5be-39c116865241"
  db_identity  = "/subscriptions/f325afb1-2e02-41d8-8c9b-f13102eebe4a/resourceGroups/rg-splg-intgp-common-uat-ger-01/providers/Microsoft.ManagedIdentity/userAssignedIdentities/id-splg-intgp-uat-ger-01"
  
  # Private Endpoints
  network_subnet_app                    = "snet-splg-intgp-db-uat-ger-01"
  network_vnet_name                     = "vnet-splg-intgp-uat-ger-01"
  resource_group_name_network           = "rg-splg-intgp-network-uat-ger-01"

  # SQL Server 
  names_server = [
    "sql-splg-intgp-uat-ger-01"
  ]
  azuread_administrator_login_username = "g-azr-dbp-cloud-admin"
  azuread_administrator_object_id      = "7cf8617d-6f9b-41de-ad1d-71095c9e8e1d" #g-azr-dbp-cloud-admin
  
  # Redis Cache   
  names_server_redis = [
    "redis-splg-intgp-uat-ger-01"
  ]
  redis_capacity                      = 1
  redis_sku_name                      = "Standard"
  redis_public_network_access_enabled = false
  
  # CosmosDB 
  names_server_cosmosdb = [
    "cosmos-splg-intgp-uat-ger-01"
  ]
  cosmosdb_automatic_failover_enabled        = false
  cosmosdb_is_virtual_network_filter_enabled = false
  cosmosdb_public_network_access_enabled     = false
  
  cosmosdb_total_throughput_limit = 4000
  cosmosdb_geo_location = {
    location            = "germanywestcentral"
    failover_priority   = 0
    zone_redundant      = false
  }
    
  cosmosdb_virtual_network_rule = {
    id                                   = "/subscriptions/f325afb1-2e02-41d8-8c9b-f13102eebe4a/resourceGroups/rg-splg-intgp-network-uat-ger-01/providers/Microsoft.Network/virtualNetworks/vnet-splg-intgp-uat-ger-01/subnets/snet-splg-intgp-db-uat-ger-01"
    ignore_missing_vnet_service_endpoint = false
  }
  
  cosmosdb_capabilities = ["EnableServerless"]
}