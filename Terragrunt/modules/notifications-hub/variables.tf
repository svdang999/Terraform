variable "name_namespace_notification_hub" {
  description = "Specifies the name which should be used for this Notification Hub. Changing this forces a new resource to be created."
  type        = string
}

variable "name_notification_hub_authorization_rule" {
  description = "Specifies the name which should be used for this Notification Hub. Changing this forces a new resource to be created."
  type        = string
}

variable "notification_hub_authorization_rule_manage" {
  description = "(Optional) Does this Authorization Rule have Manage access to the Notification Hub?"
  type        = bool
  default = false
}

variable "notification_hub_authorization_rule_send" {
  description = "(Optional) Does this Authorization Rule have Send access to the Notification Hub? "
  type        = bool
  default = false
}

variable "notification_hub_authorization_rule_listen" {
  description = "(Optional) Does this Authorization Rule have Listen access to the Notification Hub?"
  type        = bool
  default = false
}


variable "name_notification_hub" {
  description = "Specifies the name which should be used for this Notification Hub. Changing this forces a new resource to be created."
  type        = string
}

variable "namespace_name" {
  description = "Specifies the name which should be used for this Notification Hub. Changing this forces a new resource to be created."
  type        = string
  default     = ""
}

variable "namespace_type" {
  description = "Specifies the name which should be used for this Notification Hub. Changing this forces a new resource to be created."
  type        = string
}

variable "sku_name" {
  description = "Specifies the name which should be used for this Notification Hub. Changing this forces a new resource to be created."
  type        = string
}

variable "resource_group_name" {
  description = "Specifies the name of the Resource Group where the Notification Hub should exist. Changing this forces a new resource to be created."
  type        = string
}

variable "location" {
  description = "Specifies the Azure Region where the Notification Hub should exist. Changing this forces a new resource to be created."
  type        = string
}