# variable "names_nsg" {
#   description = "List of NSG names"
#   type        = list(string)
  
#   # Contract test for NSG name 
#   # validation {
#   #   condition = alltrue([
#   #     for s in var.names_nsg :
#   #     contains(
#   #       [
#   #         "nsg-a",
#   #         "nsg-b",          
#   #       ],
#   #       lower(s),
#   #     )
#   #   ])

#   #   error_message = "The name must contains ..." 

#   # }
# }

variable "names" {
  description = "List of NSG names"
  type        = list(string)
  default     = []
}

variable "names_vnet" {
  description = "List of VNET names"
  type        = list(string)
  default     = []
}

variable "names_subnet" {
  description = "List of Subnet names"
  type        = map(string)
  default     = {}
}

variable "vnet_address_space" {
  description = "List of address space VNET"
  type        = list(string)
  default     = []
}

variable "subnet_address_prefixes" {
  description = "List of subnet address prefixes space"
  type        = list(string)
  default     = []
}

variable "delegation" {
  description = "The name of the subnet delegation"
  type        = string
  default     = "delegation"
}

variable "subnet_service_delegation_name" {
  description = "The name of the subnet service delegation"
  type        = string
  default     = "Microsoft.ContainerInstance/containerGroups"
}

variable "subnet_service_delegation_action" {
  description = "The name of the subnet delegation action"
  type        = list(string)
  default     = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
}

# General vars
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

variable "network_virtual_network_subnet_id" {
  description = "The name of the virtual network subnet"
  type        = string
  default     = null
}


# variable "network_vnet_name" {
#   description = "The name of the vnet"
#   type        = string
# }

# variable "network_subnet_app" {
#   description = "The name of the app subnet"
#   type        = string
# }


# Network vars