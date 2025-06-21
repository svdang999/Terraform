# Common Variables
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "resource_group_name_network" {
  description = "The name of the resource group network components"
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "germanywestcentral"
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
  default     = {}
}

variable "network_subnet_app" {
  description = "The name of the application subnet for private endpoints"
  type        = string  
}

variable "network_vnet_name" {
  description = "The name of the virtual network for private endpoints"
  type        = string  
}

# SQL Server Variables
variable "names_server" {
  description = "List of SQL Server names to create"
  type        = list(string)
  default     = []
}

variable "sql_server_version" {
  description = "The version of SQL Server to use"
  type        = string
  default     = "12.0"
}

variable "sql_public_network_access_enabled" {
  description = "Whether public network access is enabled for SQL Server"
  type        = bool
  default     = false
}

variable "identity_type" {
  description = "The type of identity to use for SQL Server"
  type        = string
  default     = "UserAssigned"
}

variable "db_identity" {
  description = "The user assigned identity ID for the database"
  type        = string
  default     = "/subscriptions/f325afb1-2e02-41d8-8c9b-f13102eebe4a/resourceGroups/rg-splg-intgp-common-dev-ger-01/providers/Microsoft.ManagedIdentity/userAssignedIdentities/id-splg-intgp-dev-ger-01"
}

variable "azuread_administrator_login_username" {
  description = "The login username for Azure AD administrator"
  type        = string
}

variable "azuread_administrator_object_id" {
  description = "The object ID for Azure AD administrator"
  type        = string
}

variable "tenant_id" {
  description = "The Azure AD tenant ID"
  type        = string
  default     = "ca4b9986-c729-4ee0-a5be-39c116865241"
}

variable "azuread_authentication_only" {
  description = "Whether to enable Azure AD authentication only"
  type        = bool
  default     = true
}

# Redis Cache Variables
variable "names_server_redis" {
  description = "List of Redis Cache names to create"
  type        = list(string)
  default     = []
}

variable "redis_capacity" {
  description = "The size of the Redis cache to deploy"
  type        = number
  default     = 0
}

variable "redis_family" {
  description = "The SKU family to use for Redis cache"
  type        = string
  default     = "C"
}

variable "redis_sku_name" {
  description = "The SKU name for Redis cache"
  type        = string
  default     = "Standard"
}

variable "redis_public_network_access_enabled" {
  description = "Whether public network access is enabled for Redis"
  type        = bool
  default     = true
}

variable "redis_minimum_tls_version" {
  description = "The minimum TLS version for Redis"
  type        = string
  default     = "1.2"
}

variable "redis_non_ssl_port_enabled" {
  description = "Whether non-SSL port is enabled for Redis"
  type        = bool
  default     = false
}

variable "redis_access_keys_authentication_enabled" {
  description = "Whether access keys authentication is enabled for Redis"
  type        = bool
  default     = true
}

variable "redis_shard_count" {
  description = "The number of shards for Premium Redis cache"
  type        = number
  default     = 0
}

# Redis Configuration Variables
variable "redis_active_directory_authentication_enabled" {
  description = "Whether Active Directory authentication is enabled for Redis"
  type        = bool
  default     = false
}

variable "redis_aof_backup_enabled" {
  description = "Whether AOF backup is enabled for Redis"
  type        = bool
  default     = false
}

variable "redis_authentication_enabled" {
  description = "Whether authentication is enabled for Redis"
  type        = bool
  default     = true
}

variable "redis_maxfragmentationmemory_reserved" {
  description = "Value in megabytes reserved for fragmentation per shard"
  type        = number
  default     = 50
}

variable "redis_maxmemory_delta" {
  description = "Value in megabytes reserved for non-cache usage per shard"
  type        = number
  default     = 50
}

variable "redis_maxmemory_policy" {
  description = "How Redis will select what to remove when maxmemory is reached"
  type        = string
  default     = "volatile-lru"
}

variable "redis_maxmemory_reserved" {
  description = "Value in megabytes reserved for non-cache usage per shard"
  type        = number
  default     = 50
}

variable "redis_rdb_backup_enabled" {
  description = "Whether RDB backup is enabled for Redis"
  type        = bool
  default     = false
}

variable "redis_rdb_backup_max_snapshot_count" {
  description = "The maximum number of snapshots to create as a backup"
  type        = number
  default     = 0
}

# CosmosDB Variables
variable "names_server_cosmosdb" {
  description = "List of CosmosDB account names to create"
  type        = list(string)
  default     = []
}

variable "cosmosdb_automatic_failover_enabled" {
  description = "Whether automatic failover is enabled for CosmosDB"
  type        = bool
  default     = false
}

variable "cosmosdb_is_virtual_network_filter_enabled" {
  description = "Whether virtual network filtering is enabled for CosmosDB"
  type        = bool
  default     = false
}

variable "cosmosdb_public_network_access_enabled" {
  description = "Whether public network access is enabled for CosmosDB"
  type        = bool
  default     = false
}

variable "cosmosdb_offer_type" {
  description = "The offer type for CosmosDB account"
  type        = string
  default     = "Standard"
}

variable "cosmosdb_partition_merge_enabled" {
  description = "Whether partition merge is enabled for CosmosDB"
  type        = bool
  default     = false
}

# CosmosDB Analytical Storage Variables
variable "cosmosdb_analytical_storage_schema_type" {
  description = "The schema type for analytical storage"
  type        = string
  default     = "WellDefined"
}

# CosmosDB Backup Variables
variable "cosmosdb_backup_type" {
  description = "The type of backup for CosmosDB"
  type        = string
  default     = "Continuous"
}

variable "cosmosdb_backup_tier" {
  description = "The backup tier for CosmosDB"
  type        = string
  default     = "Continuous7Days"
}

variable "cosmosdb_backup_retention_in_hours" {
  description = "The backup retention period in hours"
  type        = number
  default     = 300
}

variable "cosmosdb_backup_storage_redundancy" {
  description = "The backup storage redundancy"
  type        = string
  default     = null
}

# CosmosDB Capabilities Variables
variable "cosmosdb_capabilities" {
  description = "List of capabilities to enable for CosmosDB"
  type        = list(string)
  default     = ["EnableServerless"]
}

# CosmosDB Capacity Variables
variable "cosmosdb_total_throughput_limit" {
  description = "The total throughput limit for CosmosDB"
  type        = number
  default     = 4000
}

# CosmosDB Consistency Policy Variables
variable "cosmosdb_consistency_level" {
  description = "The consistency level for CosmosDB"
  type        = string
  default     = "Session"
}

variable "cosmosdb_max_interval_in_seconds" {
  description = "The maximum staleness interval in seconds"
  type        = number
  default     = 5
}

variable "cosmosdb_max_staleness_prefix" {
  description = "The maximum staleness prefix"
  type        = number
  default     = 100
}

# CosmosDB Geo Location Variables
variable "cosmosdb_geo_location" {
  description = "The geo location configuration for CosmosDB"
  type = object({
    location          = string
    failover_priority = number
    zone_redundant    = bool
  })
  default = {
    location          = "germanywestcentral"
    failover_priority = 0
    zone_redundant    = false
  }
}

# CosmosDB Identity Variables
variable "cosmosdb_identity_type" {
  description = "The type of identity for CosmosDB"
  type        = string
  default     = "UserAssigned"
}

variable "cosmosdb_identity_ids" {
  description = "List of identity IDs for CosmosDB"
  type        = list(string)
  default     = ["/subscriptions/f325afb1-2e02-41d8-8c9b-f13102eebe4a/resourceGroups/rg-splg-intgp-common-dev-ger-01/providers/Microsoft.ManagedIdentity/userAssignedIdentities/id-splg-intgp-dev-ger-01"]
}

# CosmosDB Virtual Network Rule Variables
variable "cosmosdb_virtual_network_rule" {
  description = "Virtual network rule configuration for CosmosDB"
  type = object({
    id                                   = string
    ignore_missing_vnet_service_endpoint = bool
  })
  default = {
    id                                   = "/subscriptions/f325afb1-2e02-41d8-8c9b-f13102eebe4a/resourceGroups/rg-splg-intgp-network-dev-ger-01/providers/Microsoft.Network/virtualNetworks/vnet-splg-intgp-dev-ger-01/subnets/snet-intgp-db-dev-ger-01"
    ignore_missing_vnet_service_endpoint = false
  }
}