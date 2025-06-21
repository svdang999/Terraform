variable "sql_server_name" {
  type        = string
}

variable "names_server" {
  type        = list(string)  
  description = "list of service names"
  default = []
}

variable "names_server_redis" {
  type        = list(string)  
  description = "list of service Redis names"
  default = []
}

variable "names_server_cosmosdb" {
  type        = list(string)  
  description = "list of service CosmosDB names"
  default = []
}

variable "sql_server_name_elasticpool" {
  type        = string
}

variable "location" {
  type        = string
}

variable "resource_group_name" {
  type        = string
}

variable "resource_group_name_network" {
  type        = string
}

variable "db_identity" {
  description = "databases user identity"
  type        = string
}

variable "identity_type" {
  description = "databases identity type"
  type        = string
}


variable "azuread_administrator_object_id" {
  type        = string
}

variable "azuread_administrator_login_username" {
  type        = string
}

variable "private_endpoint_name" {
  type        = string
}

variable "private_endpoint_vnet" {
  type        = string
}

variable "private_endpoint_subnet" {
  type        = string
}

variable "tags" {
  type = map(string)
}

variable "cosmosdb_public_network_access_enabled" {
  type        = bool
  description = "Whether public network access is allowed for this server"
  default     = false
}

variable "cosmosdb_automatic_failover_enabled" {
  type        = bool
  description = "Whether automatic_failover_enabled is allowed for this server"
  default     = false
}

variable "cosmosdb_is_virtual_network_filter_enabled" {
  type        = bool
  description = "Whether cosmosdb_is_virtual_network_filter_enabled is allowed for this server"
  default     = false
}


### REDIS
variable "redis_public_network_access_enabled" {
  type        = bool
  description = "Whether public network access is allowed for this server"
  default     = false
}

variable "redis_capacity" {
  type        = number
  description = "capacity pool for Redis Server"
  default     = 0
}

variable "redis_sku_name" {
  description = "databases identity type"
  type        = string
  default     = "Standard"
}

variable "redis_family" {
  description = "databases redis family type"
  type        = string
  default     = "C"
}

