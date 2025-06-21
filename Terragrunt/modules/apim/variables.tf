variable "names_ext" {
  description = "List of API Management external names"
  type        = list(string)
  # default = [
  #   "apim-ext01",
  #   # "apim-int",    
  # ]

  # Contract test for APIM name 
  # validation {
  #   condition = alltrue([
  #     for s in var.names_ext :
  #     contains(
  #       [
  #         "apim-ext",
  #         "apim-ext02",          
  #       ],
  #       lower(s),
  #     )
  #   ])

  #   error_message = "The name must contains apim-ext name." 

  # }
}

variable "names_int" {
  description = "List of API Management external names"
  type        = list(string)
  # default = [
  #   "apim-int01",
  #   # "apim-int",    
  # ]

  # Contract test for function app name 
  # validation {
  #   condition = alltrue([
  #     for s in var.names_int :
  #     contains(
  #       [
  #         "apim-int",
  #         "apim-int02",          
  #       ],
  #       lower(s),
  #     )
  #   ])

  #   error_message = "The name must contains apim-int name." 

  # }
}

variable "tags" {
  type = map(string)
}


variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "resource_group_name_network" {
  description = "The name of the network resource group"
  type        = string
}

variable "location" {
  description = "The name of the region location"
  type        = string
}

variable "identity" {
  description = "The name of the identity account"
  type        = string
}

variable "identity_type" {
  description = "The type of the identity account"
  type        = string
  default     = "UserAssigned" 
}

variable "network_virtual_network_subnet_id" {
  description = "The name of the virtual network subnet"
  type        = string
}

variable "network_virtual_network_subnet_id_ext" {
  description = "The name of the virtual network subnet external"
  type        = string
}

variable "sku_name" {
  description = "The name of the APIM SKU"
  type        = string
}

variable "publisher_name" {
  description = "The name of the publisher"
  type        = string
}

variable "publisher_email" {
  description = "The email of the publisher account"
  type        = string
}

variable "min_api_version" {
  description = "Minimum API version of APIM"
  type        = string
}

# variable "network_vnet_name" {
#   description = "The name of the vnet"
#   type        = string
# }

# variable "network_subnet_app" {
#   description = "The name of the app subnet"
#   type        = string
# }

# variable "storage_account_name" {
#   description = "The name of the storage account"
#   type        = string
# }

# variable "logs_destinations_id" {
#   description = "The name of the diagnostic logs"
#   type        = string
# }