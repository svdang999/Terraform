# SQL Server
resource "azurerm_mssql_server" "this" {
  for_each                      = toset(var.names_server)
  name                          = each.key
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = var.sql_server_version
  public_network_access_enabled = var.sql_public_network_access_enabled
  
  identity {
    type = var.identity_type
    identity_ids = [
      var.db_identity
    ] 
  }
  
  azuread_administrator {
    login_username              = var.azuread_administrator_login_username
    object_id                   = var.azuread_administrator_object_id
    tenant_id                   = var.tenant_id
    azuread_authentication_only = var.azuread_authentication_only
  }
  
  primary_user_assigned_identity_id = var.db_identity
  tags = var.tags
  
  lifecycle {
    ignore_changes = [
      tags,
      administrator_login_password,
      express_vulnerability_assessment_enabled,
      azuread_administrator[0].azuread_authentication_only
    ]
  }
}

# Private Endpoints
module "sql_pe" {
  providers = {
    azurerm.connectivity = azurerm.connectivity,
    azurerm              = azurerm
  }
  for_each            = toset(var.names_server)
  source              = "../../../../../..//dbp-cloud-platform-sharedmodule-iac/networking/private-endpoint" #/dbp-integration-platform-iac/ - germanywestcentral/dev/app-configuration/.terragrunt-cache/jZtRt6XrV4LIcXiSZHaBsE4SBRA/kgBE3M_I3KF6M1oTFk3G9SH3Aug

  name                = "pep-${each.key}"
  resource_group_name = var.resource_group_name_network
  location            = var.location
  subnet = {
    subnet_name         = var.network_subnet_app
    vnet_name           = var.network_vnet_name
    resource_group_name = var.resource_group_name_network
  }
  custom_network_interface_name = "pep-${each.key}"
  private_service_connection = {
    name                           = "pep-${each.key}"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_mssql_server.this[each.key].id
    subresource_names              = ["sqlServer"] #https://docs.microsoft.com/en-us/azure/private-link/private-endpoint-overview#private-link-resource
  }
  private_dns_zone_group_name = "default"
  private_dns_zone_names      = ["privatelink.database.windows.net"]
  private_dns_zone_rg         = "rg-splg-dns-zone-ger-01"
  tags = var.tags
}


# Redis Cache
resource "azurerm_redis_cache" "this" {
  for_each                            = toset(var.names_server_redis)
  name                                = each.key
  resource_group_name                 = var.resource_group_name
  location                            = var.location
  access_keys_authentication_enabled  = var.redis_access_keys_authentication_enabled
  capacity                            = var.redis_capacity
  family                              = var.redis_family
  minimum_tls_version                 = var.redis_minimum_tls_version
  non_ssl_port_enabled                = var.redis_non_ssl_port_enabled
  public_network_access_enabled       = var.redis_public_network_access_enabled
  shard_count                         = var.redis_shard_count
  sku_name                            = var.redis_sku_name
  tags                                = var.tags

  identity {
    type = var.identity_type
    identity_ids = [
      var.db_identity
    ] 
  }

  redis_configuration {
    active_directory_authentication_enabled = var.redis_active_directory_authentication_enabled
    aof_backup_enabled                      = var.redis_aof_backup_enabled
    authentication_enabled                  = var.redis_authentication_enabled
    maxfragmentationmemory_reserved         = var.redis_maxfragmentationmemory_reserved
    maxmemory_delta                         = var.redis_maxmemory_delta
    maxmemory_policy                        = var.redis_maxmemory_policy
    maxmemory_reserved                      = var.redis_maxmemory_reserved
    rdb_backup_enabled                      = var.redis_rdb_backup_enabled
    rdb_backup_max_snapshot_count           = var.redis_rdb_backup_max_snapshot_count
  }

  lifecycle {
    ignore_changes = [
      redis_configuration,
      identity
    ]
  }
}

# Private Endpoints
module "redis_pe" {
  providers = {
    azurerm.connectivity = azurerm.connectivity,
    azurerm              = azurerm
  }
  for_each            = toset(var.names_server_redis)
  source              = "../../../../../..//dbp-cloud-platform-sharedmodule-iac/networking/private-endpoint" #/dbp-integration-platform-iac/ - germanywestcentral/dev/app-configuration/.terragrunt-cache/jZtRt6XrV4LIcXiSZHaBsE4SBRA/kgBE3M_I3KF6M1oTFk3G9SH3Aug

  name                = "pep-${each.key}"
  resource_group_name = var.resource_group_name_network
  location            = var.location
  subnet = {
    subnet_name         = var.network_subnet_app
    vnet_name           = var.network_vnet_name
    resource_group_name = var.resource_group_name_network
  }
  custom_network_interface_name = "pep-${each.key}"
  private_service_connection = {
    name                           = "pep-${each.key}"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_redis_cache.this[each.key].id
    subresource_names              = ["redisCache"] #https://docs.microsoft.com/en-us/azure/private-link/private-endpoint-overview#private-link-resource
  }
  private_dns_zone_group_name = "default"
  private_dns_zone_names      = ["privatelink.redis.cache.windows.net"]
  private_dns_zone_rg         = "rg-splg-dns-zone-ger-01"
  tags = var.tags
}

# CosmosDB Account
resource "azurerm_cosmosdb_account" "this" {
  for_each                              = toset(var.names_server_cosmosdb)
  name                                  = each.key
  resource_group_name                   = var.resource_group_name
  location                              = var.location
  automatic_failover_enabled            = var.cosmosdb_automatic_failover_enabled
  # is_virtual_network_filter_enabled     = var.cosmosdb_is_virtual_network_filter_enabled
  offer_type                           = var.cosmosdb_offer_type
  partition_merge_enabled              = var.cosmosdb_partition_merge_enabled
  public_network_access_enabled        = var.cosmosdb_public_network_access_enabled
  tags                                 = var.tags

  analytical_storage {
    schema_type = var.cosmosdb_analytical_storage_schema_type
  }

  backup {
    storage_redundancy  = var.cosmosdb_backup_storage_redundancy
    tier                = var.cosmosdb_backup_tier
    type                = var.cosmosdb_backup_type
    # retention_in_hours  = var.cosmosdb_backup_retention_in_hours
  }

  dynamic "capabilities" {
    for_each = var.cosmosdb_capabilities
    content {
      name = capabilities.value
    }
  }

  capacity {
    total_throughput_limit = var.cosmosdb_total_throughput_limit
  }

  consistency_policy {
    consistency_level       = var.cosmosdb_consistency_level
    max_interval_in_seconds = var.cosmosdb_max_interval_in_seconds
    max_staleness_prefix    = var.cosmosdb_max_staleness_prefix
  }

  geo_location {
    failover_priority = var.cosmosdb_geo_location.failover_priority
    location          = var.cosmosdb_geo_location.location
    zone_redundant    = var.cosmosdb_geo_location.zone_redundant
  }

  identity {
    type = var.identity_type
    identity_ids = [
      var.db_identity
    ] 
  }



  lifecycle {
    ignore_changes = [
      # backup,
      # capabilities,
      # capacity,
    ]
  }
}

# Private Endpoints
module "cosmosdb_pe" {
  providers = {
    azurerm.connectivity = azurerm.connectivity,
    azurerm              = azurerm
  }
  for_each            = toset(var.names_server_cosmosdb)
  source              = "../../../../../..//dbp-cloud-platform-sharedmodule-iac/networking/private-endpoint" #/dbp-integration-platform-iac/ - germanywestcentral/dev/app-configuration/.terragrunt-cache/jZtRt6XrV4LIcXiSZHaBsE4SBRA/kgBE3M_I3KF6M1oTFk3G9SH3Aug

  name                = "pep-${each.key}"
  resource_group_name = var.resource_group_name_network
  location            = var.location
  subnet = {
    subnet_name         = var.network_subnet_app
    vnet_name           = var.network_vnet_name
    resource_group_name = var.resource_group_name_network
  }
  custom_network_interface_name = "pep-${each.key}"
  private_service_connection = {
    name                           = "pep-${each.key}"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_cosmosdb_account.this[each.key].id
    subresource_names              = ["SQL"] #https://docs.microsoft.com/en-us/azure/private-link/private-endpoint-overview#private-link-resource
  }
  private_dns_zone_group_name = "default"
  private_dns_zone_names      = ["privatelink.documents.azure.com"]
  private_dns_zone_rg         = "rg-splg-dns-zone-ger-01"
  tags = var.tags
}