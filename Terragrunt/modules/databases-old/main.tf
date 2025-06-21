# import {
#   for_each = toset(var.names_server)
#   to = azurerm_mssql_server.this[each.key]  
#   id = "/subscriptions/8b4ce84d-8f95-4d64-9740-2f565448b5d5/resourceGroups/rg-splg-logsp-common-ppd-ger-01/providers/Microsoft.Sql/servers/${each.key}"  
# }

# import {
#   for_each = toset(var.names_server_redis)
#   to = azurerm_redis_cache.this[each.key]  
#   id = "/subscriptions/8b4ce84d-8f95-4d64-9740-2f565448b5d5/resourceGroups/rg-splg-logsp-common-ppd-ger-01/providers/Microsoft.Cache/redis/${each.key}"  
# }

# import {
#   for_each = toset(var.names_server_cosmosdb)
#   to = azurerm_cosmosdb_account.this[each.key]  
#   id = "/subscriptions/8b4ce84d-8f95-4d64-9740-2f565448b5d5/resourceGroups/rg-splg-logsp-common-ppd-ger-01/providers/Microsoft.DocumentDB/databaseAccounts/${each.key}"  
# }

resource "azurerm_mssql_server" "this" {
  for_each                      = toset(var.names_server)
  name                          = each.key
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = "12.0"
  # administrator_login           = "sqlintgppadmin"
  public_network_access_enabled = false
  identity {
    type = var.identity_type #"SystemAssigned, UserAssigned"
    identity_ids = [
      var.db_identity
    ] 
  }
  azuread_administrator {
    login_username              = var.azuread_administrator_login_username
    object_id                   = var.azuread_administrator_object_id
    tenant_id                   = "ca4b9986-c729-4ee0-a5be-39c116865241" #SPL Digital
    azuread_authentication_only = true
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

## Redis
resource "azurerm_redis_cache" "this" {
    for_each                            = toset(var.names_server_redis)
    name                                = each.key
    access_keys_authentication_enabled  = true
    capacity                            = var.redis_capacity #0
    family                              = var.redis_family #"C"    
    minimum_tls_version                 = "1.2"    
    non_ssl_port_enabled                = false
    public_network_access_enabled       = var.redis_public_network_access_enabled #true
    shard_count                         = 0
    sku_name                            = var.redis_sku_name #"Standard"
    resource_group_name                 = var.resource_group_name
    location                            = var.location

    redis_configuration {
        active_directory_authentication_enabled = false
        aof_backup_enabled                      = false
        authentication_enabled                  = true
        maxfragmentationmemory_reserved         = 50
        maxmemory_delta                         = 50
        maxmemory_policy                        = "volatile-lru"
        maxmemory_reserved                      = 50
        rdb_backup_enabled                      = false
        rdb_backup_max_snapshot_count           = 0
    }

    lifecycle {
      ignore_changes = [
        tags,
        redis_configuration,
        identity
      ]
    }
}

## CosmosDB
resource "azurerm_cosmosdb_account" "this" {
    for_each                                  = toset(var.names_server_cosmosdb)
    name                                      = each.key
    resource_group_name                       = var.resource_group_name
    location                                  = var.location
    automatic_failover_enabled                = var.cosmosdb_automatic_failover_enabled
    is_virtual_network_filter_enabled         = var.cosmosdb_is_virtual_network_filter_enabled

    offer_type                               = "Standard"
    partition_merge_enabled                  = false
    public_network_access_enabled            = var.cosmosdb_public_network_access_enabled
    tags                                     = var.tags

    analytical_storage {
        schema_type = "WellDefined"
    }

    backup {
        storage_redundancy  = null
        tier                = "Continuous7Days"
        type                = "Continuous"
        retention_in_hours  = 300
    }

    capabilities {
        name = "EnableServerless"
    }

    capacity {
        total_throughput_limit = 4000
    }

    consistency_policy {
        consistency_level       = "Session"
        max_interval_in_seconds = 5
        max_staleness_prefix    = 100
    }

    geo_location {
        failover_priority = 0
        location          = "germanywestcentral"
        zone_redundant    = false
    }

    identity {
        identity_ids = [
            "/subscriptions/f325afb1-2e02-41d8-8c9b-f13102eebe4a/resourceGroups/rg-splg-intgp-common-dev-ger-01/providers/Microsoft.ManagedIdentity/userAssignedIdentities/id-splg-intgp-dev-ger-01",
        ]
        principal_id = null
        tenant_id    = null
        type         = "UserAssigned"
    }

    virtual_network_rule {
        id                                   = "/subscriptions/f325afb1-2e02-41d8-8c9b-f13102eebe4a/resourceGroups/rg-splg-intgp-network-dev-ger-01/providers/Microsoft.Network/virtualNetworks/vnet-splg-intgp-dev-ger-01/subnets/snet-intgp-db-dev-ger-01"
        ignore_missing_vnet_service_endpoint = false
    }

    lifecycle {
      ignore_changes = [
        tags,
        endpoint,
        id,        
        ip_range_filter,
        backup,
        capabilities,
        capacity,
        virtual_network_rule,
        identity
      ]
    }
}