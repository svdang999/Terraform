
variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
  default     = ""
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = null
}

variable "location" {
  description = "The location of the resource group"
  type        = string
  default     = null
}

variable "tags" {
  description = "The tags names"
  type = map(string)
  default = {}
}

variable "names" {
  type          = list(string)  
  default       = []
  description   = "service name's list"
}

variable "virtual_network_subnet_ids" {
  type          = list(string)  
  default       = []
  description   = "vnet subnet id list"
}

variable "public_network_access_enabled" {
  description = "The Public Network Access setting of the App. Possible values are true and false."
  type        = bool
  default     = true
}

variable "account_replication_type" {
  description = "The name of the diagnostic logs"
  type        = string
  default     = "GRS"
}

variable "allow_nested_items_to_be_public" {
  description = "Allow nested item public or private. Possible values are true and false."
  type        = bool
  default     = true
}