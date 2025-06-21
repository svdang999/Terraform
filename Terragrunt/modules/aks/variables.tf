# modules/aks-cluster/variables.tf

variable "cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "node_resource_group_name" {
  description = "Name of the node resource group"
  type        = string
}

variable "vnet_subnet_id" {
  description = "ID of the subnet where AKS nodes will be deployed"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

# AKS Configuration
variable "azure_policy_enabled" {
  description = "Enable Azure Policy for AKS"
  type        = bool
  default     = true
}

variable "cost_analysis_enabled" {
  description = "Enable cost analysis for AKS"
  type        = bool
  default     = true
}

variable "http_application_routing_enabled" {
  description = "Enable HTTP application routing"
  type        = bool
  default     = false
}

variable "image_cleaner_enabled" {
  description = "Enable image cleaner"
  type        = bool
  default     = true
}

variable "image_cleaner_interval_hours" {
  description = "Image cleaner interval in hours"
  type        = number
  default     = 168
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.32.0"
}

variable "local_account_disabled" {
  description = "Disable local accounts"
  type        = bool
  default     = true
}

variable "node_os_upgrade_channel" {
  description = "Node OS upgrade channel"
  type        = string
  default     = "NodeImage"
}

variable "oidc_issuer_enabled" {
  description = "Enable OIDC issuer"
  type        = bool
  default     = true
}

variable "open_service_mesh_enabled" {
  description = "Enable Open Service Mesh"
  type        = bool
  default     = false
}

variable "private_cluster_enabled" {
  description = "Enable private cluster"
  type        = bool
  default     = true
}

variable "private_cluster_public_fqdn_enabled" {
  description = "Enable public FQDN for private cluster"
  type        = bool
  default     = false
}

variable "private_dns_zone_id" {
  description = "Private DNS zone ID"
  type        = string
  default     = "System"
}

variable "role_based_access_control_enabled" {
  description = "Enable RBAC"
  type        = bool
  default     = true
}

variable "run_command_enabled" {
  description = "Enable run command"
  type        = bool
  default     = true
}

variable "sku_tier" {
  description = "AKS SKU tier"
  type        = string
  default     = "Standard"
}

variable "support_plan" {
  description = "AKS support plan"
  type        = string
  default     = "KubernetesOfficial"
}

variable "workload_identity_enabled" {
  description = "Enable workload identity"
  type        = bool
  default     = true
}

# Azure AD RBAC
variable "admin_group_object_ids" {
  description = "List of Azure AD group object IDs for cluster admin access"
  type        = list(string)
}

variable "azure_rbac_enabled" {
  description = "Enable Azure RBAC"
  type        = bool
  default     = true
}

variable "tenant_id" {
  description = "Azure AD tenant ID"
  type        = string
}

# Default Node Pool Configuration
variable "default_node_pool" {
  description = "Default node pool configuration"
  type = object({
    auto_scaling_enabled = bool
    node_count          = number
    min_count           = optional(number)
    max_count           = optional(number)
    max_pods            = number
    name                = string
    orchestrator_version = string
    vm_size             = string
    zones               = list(string)
    max_surge           = string
  })
  default = {
    auto_scaling_enabled = false
    node_count          = 2
    min_count           = null
    max_count           = null
    max_pods            = 60
    name                = "npsystem"
    orchestrator_version = "1.32.0"
    vm_size             = "Standard_D2ps_v6"
    zones               = ["1", "2", "3"]
    max_surge           = "10%"
  }
}

# Identity Configuration
variable "identity_type" {
  description = "Type of identity for AKS cluster"
  type        = string
  default     = "UserAssigned"
}

variable "identity_ids" {
  description = "List of user assigned identity IDs"
  type        = list(string)
}

# Network Profile
variable "network_profile" {
  description = "Network profile configuration"
  type = object({
    ip_versions         = list(string)
    load_balancer_sku   = string
    network_data_plane  = string
    network_plugin      = string
    network_plugin_mode = string
    network_policy      = string
    outbound_type       = string
  })
  default = {
    ip_versions         = ["IPv4"]
    load_balancer_sku   = "standard"
    network_data_plane  = "cilium"
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
    network_policy      = "cilium"
    outbound_type       = "loadBalancer"
  }
}

# Key Vault Secrets Provider
variable "key_vault_secrets_provider" {
  description = "Key Vault secrets provider configuration"
  type = object({
    secret_rotation_enabled  = bool
    secret_rotation_interval = string
  })
  default = {
    secret_rotation_enabled  = false
    secret_rotation_interval = "2m"
  }
}

# Service Mesh Profile (optional)
variable "service_mesh_profile" {
  description = "Service mesh profile configuration"
  type = object({
    mode                             = string
    revisions                        = list(string)
    internal_ingress_gateway_enabled = bool
    external_ingress_gateway_enabled = bool
  })
  default = null
}

# OMS Agent
variable "log_analytics_workspace_id" {
  description = "Log Analytics workspace ID"
  type        = string
}

variable "msi_auth_for_monitoring_enabled" {
  description = "Enable MSI auth for monitoring"
  type        = bool
  default     = true
}

# Lifecycle
variable "lifecycle_ignore_changes" {
  description = "List of attributes to ignore changes for"
  type        = list(string)
  default = [
    "microsoft_defender",
    "monitor_metrics",
    "default_node_pool.0.node_count"
  ]
}

# Additional Node Pools
variable "additional_node_pools" {
  description = "Additional node pools configuration"
  type = map(object({
    auto_scaling_enabled      = bool
    node_count               = number
    min_count                = optional(number)
    max_count                = optional(number)
    max_pods                 = number
    mode                     = string
    orchestrator_version     = string
    vm_size                  = string
    vnet_subnet_id_nodepool  = string
    zones                    = optional(list(string))
    max_surge                = optional(string)
    lifecycle_ignore_changes = optional(list(string), [])
  }))
  default = {}
}