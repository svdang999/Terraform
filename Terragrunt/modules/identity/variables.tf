variable "names" {
  type        = list(string)  
  default = []
  description = "identity list name"
}


variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resource group"
  type        = string
}

variable "tags" {
  type = map(string)
}