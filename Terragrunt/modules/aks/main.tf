# import {
#   to            = azurerm_kubernetes_cluster.this
#   id            = "/subscriptions/4413e1f9-5c85-4fe3-ac08-e4471945ea01/resourceGroups/rg-splg-cloudp-runner-common-ger-01/providers/Microsoft.ContainerService/managedClusters/aks-splg-cloudp-devops-runner-ger-01"  
# }

# import {
#   for_each      = var.additional_node_pools
#   to            = azurerm_kubernetes_cluster_node_pool.additional[each.key]  
#   id            = "/subscriptions/4413e1f9-5c85-4fe3-ac08-e4471945ea01/resourceGroups/rg-splg-cloudp-runner-common-ger-01/providers/Microsoft.ContainerService/managedClusters/aks-splg-cloudp-devops-runner-ger-01/agentPools/${each.key}"  
# }

resource "azurerm_kubernetes_cluster" "this" {
  azure_policy_enabled                = var.azure_policy_enabled
  cost_analysis_enabled               = var.cost_analysis_enabled
  dns_prefix                          = "${var.cluster_name}-dns"
  http_application_routing_enabled    = var.http_application_routing_enabled
  # image_cleaner_enabled               = var.image_cleaner_enabled
  # image_cleaner_interval_hours        = var.image_cleaner_interval_hours
  kubernetes_version                  = var.kubernetes_version
  local_account_disabled              = var.local_account_disabled
  location                            = var.location
  name                                = var.cluster_name
  node_os_upgrade_channel             = var.node_os_upgrade_channel
  node_resource_group                 = var.node_resource_group_name
  oidc_issuer_enabled                 = var.oidc_issuer_enabled
  open_service_mesh_enabled           = var.open_service_mesh_enabled
  private_cluster_enabled             = var.private_cluster_enabled
  private_cluster_public_fqdn_enabled = var.private_cluster_public_fqdn_enabled
  private_dns_zone_id                 = var.private_dns_zone_id
  resource_group_name                 = var.resource_group_name
  role_based_access_control_enabled   = var.role_based_access_control_enabled
  run_command_enabled                 = var.run_command_enabled
  sku_tier                            = var.sku_tier
  support_plan                        = var.support_plan
  tags                                = var.tags
  workload_identity_enabled           = var.workload_identity_enabled

  azure_active_directory_role_based_access_control {
    admin_group_object_ids = var.admin_group_object_ids
    azure_rbac_enabled     = var.azure_rbac_enabled
    tenant_id              = var.tenant_id
  }

  default_node_pool {
    auto_scaling_enabled = var.default_node_pool.auto_scaling_enabled
    node_count          = var.default_node_pool.node_count
    min_count           = var.default_node_pool.min_count
    max_count           = var.default_node_pool.max_count
    max_pods            = var.default_node_pool.max_pods
    name                = var.default_node_pool.name
    orchestrator_version = var.default_node_pool.orchestrator_version
    tags                = var.tags
    vm_size             = var.default_node_pool.vm_size
    vnet_subnet_id      = var.vnet_subnet_id
    zones               = var.default_node_pool.zones

  }

  identity {
    type         = var.identity_type
    identity_ids = var.identity_ids
  }

  network_profile {
    ip_versions         = var.network_profile.ip_versions
    load_balancer_sku   = var.network_profile.load_balancer_sku
    network_data_plane  = var.network_profile.network_data_plane
    network_plugin      = var.network_profile.network_plugin
    network_plugin_mode = var.network_profile.network_plugin_mode
    network_policy      = var.network_profile.network_policy
    outbound_type       = var.network_profile.outbound_type
  }

  key_vault_secrets_provider {
    secret_rotation_enabled  = var.key_vault_secrets_provider.secret_rotation_enabled
    secret_rotation_interval = var.key_vault_secrets_provider.secret_rotation_interval
  }

  lifecycle {
    ignore_changes = [
      tags,
      identity,
      oms_agent,
      dns_prefix,
      auto_scaler_profile,
      default_node_pool[0].tags,
      default_node_pool[0].zones,
      default_node_pool[0].upgrade_settings,
    ]
  }
}

# Additional node pools
resource "azurerm_kubernetes_cluster_node_pool" "additional" {
  for_each = var.additional_node_pools

  kubernetes_cluster_id = azurerm_kubernetes_cluster.this.id
  name                 = each.key
  auto_scaling_enabled = each.value.auto_scaling_enabled
  node_count          = each.value.node_count
  min_count           = each.value.min_count
  max_count           = each.value.max_count
  max_pods            = each.value.max_pods
  mode                = each.value.mode
  orchestrator_version = each.value.orchestrator_version
  tags                = var.tags
  vm_size             = each.value.vm_size
  vnet_subnet_id      = each.value.vnet_subnet_id_nodepool 
  zones               = each.value.zones

  dynamic "upgrade_settings" {
    for_each = each.value.max_surge != null ? [each.value.max_surge] : []
    content {
      max_surge = upgrade_settings.value
    }
  }

  lifecycle {
    ignore_changes = [
      tags,
      upgrade_settings,
      zones
    ]
  }
}