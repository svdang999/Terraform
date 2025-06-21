variable "environment" {
  description = "Environment name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "germanywestcentral"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "servicebus_namespace_name" {
  description = "Name of the Service Bus namespace"
  type        = string
}

variable "servicebus_sku" {
  description = "SKU of the Service Bus namespace"
  type        = string
  default     = "Standard"
}

variable "requires_session" {
  description = "Indicates if sessions are required for subscriptions"
  type        = bool
  default     = false  
}

variable "dead_lettering_on_filter_evaluation_error" {
  description = "Indicates if dead lettering should occur on filter evaluation error"
  type        = bool
  default     = true  
}

variable "topics" {
  description = "Map of topics and their subscriptions"
  type = map(object({
    partitioning_enabled = bool
    max_size_in_megabytes = optional(number, 20480) # Default value
    requires_duplicate_detection = optional(bool, false) # Default value  
    support_ordering = optional(bool, false) # Default value

    subscriptions = map(object({
        max_delivery_count = number
        dead_lettering_on_message_expiration = bool
        enable_batched_operations = bool
        requires_session = optional(bool, false) # Default value
        dead_lettering_on_filter_evaluation_error = optional(bool, true) # Default value
    }))
  }))
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}