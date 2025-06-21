variable "names" {
  description = "List of function app names"
  type        = list(string)
  default = []

  # Contract test for function app name 
  # validation {
  #   condition = alltrue([
  #     for s in var.names :
  #     contains(
  #       [
  #         "chatbottest011",
  #         "efaa-processortest011",          
  #       ],
  #       lower(s),
  #     )
  #   ])

  #   error_message = "The function app name must contains chatbottest011 name." 

  # }
}

variable "names_linux" {
  description = "List of function app names Linux"
  type        = list(string)
  default = []

  # Contract test for function app name 
  # validation {
  #   condition = alltrue([
  #     for s in var.names :
  #     contains(
  #       [
  #         "chatbottest011",
  #         "efaa-processortest011",          
  #       ],
  #       lower(s),
  #     )
  #   ])

  #   error_message = "The function app name must contains chatbottest011 name." 

  # }
}

variable "tags" {
  type = map(string)
  description = "the name of tags list"
}

variable "environment" {
  description = "The name of the environment dev/uat/prd"
  type        = string

  # Contract test for environment length 
  validation {
    condition = length(var.environment) <= 10
    error_message = "The environment length must be less than or equal to 10 characters."
  }
}

variable "platform" {
  description = "The name of the platform i.e intgp/logsp"
  type        = string
}

variable "app_service_plan_name" {
  description = "The name of the App Service Plan"
  type        = string
}

variable "app_service_plan_linux_name" {
  description = "The name of the App Service Plan Linux"
  type        = string
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

variable "network_vnet_name" {
  description = "The name of the vnet"
  type        = string
}

variable "network_subnet_app" {
  description = "The name of the app subnet"
  type        = string
}

variable "network_virtual_network_subnet_id" {
  description = "The name of the virtual network subnet"
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}

variable "identity" {
  description = "The name of the identity account"
  type        = string
}

variable "logs_destinations_id" {
  description = "The name of the diagnostic logs"
  type        = string
}

variable "public_network_access" {
  description = "The Public Network Access setting of the App. Possible values are true and false."
  type        = bool
  default     = true
}


variable "sku_name" {
  description = "The SKU for the plan. Possible values include B1, B2, B3, D1, F1, I1, I2, I3, I1v2, I1mv2, I2v2, I2mv2, I3v2, I3mv2, I4v2, I4mv2, I5v2, I5mv2, I6v2, P1v2, P2v2, P3v2, P0v3, P1v3, P2v3, P3v3, P1mv3, P2mv3, P3mv3, P4mv3, P5mv3, S1, S2, S3, SHARED, EP1, EP2, EP3, FC1, WS1, WS2, WS3, and Y1."
  type        = string
  default     = "P1v2" #Free
}