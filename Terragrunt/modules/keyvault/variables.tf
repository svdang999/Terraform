
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "resource_group_name_network" {
  description = "The name of the resource group for Networking components"
  type        = string
}

variable "location" {
  description = "The location of the resource group"
  type        = string
}

variable "tenant_id" {
  description = "The ID of the tenant"
  type        = string
}

variable "private_endpoint_name" {
  description = "The name of the private endpoint"
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}

variable "vnet_name" {
  description = "The name of the vnet"
  type        = string
}

variable "tags" {
  type = map(string)
}

variable "names" {
  type        = list(string)  
  default = []
  description = "list of key vault name"
}