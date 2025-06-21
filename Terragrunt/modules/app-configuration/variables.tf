variable "location" {
  type        = string
}

variable "environment" {
  type        = string
}

variable "platform" {
  type        = string
}

variable "resource_group_name" {
  type        = string
}

variable "resource_group_name_network" {
  type        = string
}

variable "identity" {
  description = "A list of User Assigned Managed Identity IDs to be assigned to this App Configuration. This is required when type is set to UserAssigned or SystemAssigned, UserAssigned"
  type        = string
}

variable "public_network_access" {
  description = "The Public Network Access setting of the App Configuration. Possible values are Enabled and Disabled."
  type        = string
  default     = "Enabled"
}

variable "sku" {
  type        = string
  description = "The SKU name of the App Configuration. Possible values are free, standard and premium"
  default     = "standard"
}

variable "azuread_administrator_object_id" {
  type        = string
  description = "name of admin object id"
}

variable "azuread_administrator_login_username" {
  type        = string
  description = "name of admin user"
}

# variable "private_endpoint_name" {
#   type        = string
#   description = "name of private endpoint"
# }

variable "private_endpoint_vnet" {
  type        = string
  description = "name of private endpoint vnet"
}

variable "private_endpoint_subnet" {
  type        = string
  description = "name of private endpoint subnet"
  default     = null
}

variable "tags" {
  type = map(string)
  description = "list of tags"
  default = {}
}

variable "names" {
  type        = list(string)  
  description = "list of app configuration names"
  default = []
}

# variable "logs_destinations_ids" {
#   type = map(string)
# }


variable "soft_delete_retention_days" {
  type        = number
  description = "define delete retention for app configuration. change will cause resource recreation"
  default = 7
}

variable "purge_protection_enabled" {
  type        = bool
  description = "define purge protection"
  default     = false
}