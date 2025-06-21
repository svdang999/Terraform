##General vars
variable "location" {
  type        = string
}

variable "region_short" {
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
  description = "user identity"
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

variable "names_servicebus" {
  type        = list(string)  
  default     = []
  description = "service bus name"
}

variable "names_servicebus_topic" {
  type        = list(string)  
  default     = []
  description = "service bus topic name"
}

variable "names_servicebus_subscription" {
  type        = list(string)  
  default     = []
  description = "service bus subscription name"
}

variable "names_eventhub" {
  type        = list(string)  
  default     = []
  description = "service bus namespace"
}

# variable "logs_destinations_ids" {
#   type = map(string)
# }


