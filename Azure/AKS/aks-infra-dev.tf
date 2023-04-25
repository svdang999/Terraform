terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.53.0" #https://registry.terraform.io/providers/hashicorp/azurerm/latest
    }
  }
    backend "azurerm" {
        resource_group_name  = "rg-infra-test"
        storage_account_name = "storedev"
        container_name       = "tfstate"
        key                  = "devtest-aks-infra-dev.terraform.tfstate"
    }

}

provider "azurerm" {
  features {}
  subscription_id   = "xxx" # Microsoft Partner Network Subscription
  tenant_id         = "xxx" # Dev_Test Smartbilling Pay-As-You-Go Tenant
  client_id         = "xxx" # Terraform service principal ID
  client_secret     = "xxx" # Terraform service principal secret
}


resource "azurerm_kubernetes_cluster" "aks_cluster" {
    automatic_channel_upgrade           = "patch"
    azure_policy_enabled                = false
    dns_prefix                          = "aks-infra-dev-dns"
    http_application_routing_enabled    = false
    kubernetes_version                  = "1.24.10"
    local_account_disabled              = false
    location                            = "southeastasia"
    name                                = "aks-infra-dev"
    node_resource_group                 = "MC_rg-infra-son-test_aks-infra-dev_southeastasia"
    oidc_issuer_enabled                 = false
    open_service_mesh_enabled           = false
    private_cluster_enabled             = false
    private_cluster_public_fqdn_enabled = false
    public_network_access_enabled       = true
    resource_group_name                 = "rg-infra-son-test"
    role_based_access_control_enabled   = true
    run_command_enabled                 = true
    sku_tier                            = "Free"
    tags                                = {
        managed_by  = "Terraform"
        environment = "dev"
        team        = "Infra"
    }
    workload_identity_enabled           = false

    default_node_pool {
        custom_ca_trust_enabled      = false
        enable_auto_scaling          = false
        enable_host_encryption       = false
        enable_node_public_ip        = false
        fips_enabled                 = false
        kubelet_disk_type            = "OS"
        max_count                    = null
        max_pods                     = 200
        min_count                    = null
        name                         = "agentpool"
        node_count                   = 1
        node_labels                  = {}
        node_taints                  = []
        only_critical_addons_enabled = false
        orchestrator_version         = "1.24.10"
        os_disk_size_gb              = 128
        os_disk_type                 = "Managed"
        os_sku                       = "Ubuntu"
        scale_down_mode              = "Delete"
        tags                         = {}
        type                         = "VirtualMachineScaleSets"
        ultra_ssd_enabled            = false
        vm_size                      = "Standard_B2s"
        vnet_subnet_id               = "/subscriptions/9b92b540-a481-460c-aeaf-9edb236a1481/resourceGroups/rg-infra-son-test/providers/Microsoft.Network/virtualNetworks/rginfrasontestvnet877/subnets/default"
        zones                        = []
    }

    identity {
        identity_ids = []
        type         = "SystemAssigned"
    }

    network_profile {
        dns_service_ip     = "10.0.0.10"
        ip_versions        = [
            "IPv4",
        ]
        load_balancer_sku  = "standard"
        network_plugin     = "azure"
        outbound_type      = "loadBalancer"
        pod_cidrs          = []
        service_cidr       = "10.0.0.0/16"
        service_cidrs      = [
            "10.0.0.0/16",
        ]

        load_balancer_profile {            
            idle_timeout_in_minutes     = 5
            outbound_ports_allocated    = 0
        }
    }

}

resource "azurerm_kubernetes_cluster_node_pool" "linux01" {
    custom_ca_trust_enabled = false
    enable_auto_scaling     = false
    enable_host_encryption  = false
    enable_node_public_ip   = false
    fips_enabled            = false
    kubelet_disk_type       = "OS"
    kubernetes_cluster_id   = "/subscriptions/9b92b540-a481-460c-aeaf-9edb236a1481/resourceGroups/rg-infra-son-test/providers/Microsoft.ContainerService/managedClusters/aks-infra-dev" 
    max_count               = 0
    max_pods                = 150
    min_count               = 0
    mode                    = "User"
    name                    = "linux"
    node_count              = 1
    node_labels             = {}
    node_taints             = []
    orchestrator_version    = "1.24.10"
    os_disk_size_gb         = 128
    os_disk_type            = "Managed"
    os_sku                  = "Ubuntu"
    os_type                 = "Linux"
    priority                = "Regular"
    scale_down_mode         = "Delete"
    spot_max_price          = -1
    ultra_ssd_enabled       = false
    vm_size                 = "Standard_B2s"
    vnet_subnet_id          = "/subscriptions/9b92b540-a481-460c-aeaf-9edb236a1481/resourceGroups/rg-infra-son-test/providers/Microsoft.Network/virtualNetworks/rginfrasontestvnet877/subnets/default"
    zones                   = []

    timeouts {}
    
    tags                                = {
        managed_by  = "Terraform"
        environment = "dev"
        team        = "Infra"
        pool        = "linuxpool"
    }
}

// resource "azurerm_kubernetes_cluster_node_pool" "windows01" {
//     custom_ca_trust_enabled = false
//     enable_auto_scaling     = false
//     enable_host_encryption  = false
//     enable_node_public_ip   = false
//     fips_enabled            = false
//     kubelet_disk_type       = "OS"
//     kubernetes_cluster_id   = "/subscriptions/9b92b540-a481-460c-aeaf-9edb236a1481/resourceGroups/rg-infra-son-test/providers/Microsoft.ContainerService/managedClusters/aks-infra-dev" 
//     max_count               = 0
//     max_pods                = 150
//     min_count               = 0
//     mode                    = "User"
//     name                    = "win"
//     node_count              = 0
//     node_labels             = {}
//     node_taints             = []
//     orchestrator_version    = "1.24.10"
//     os_disk_size_gb         = 128
//     os_disk_type            = "Managed"
//     os_sku                  = "Windows2019"
//     os_type                 = "Windows"
//     priority                = "Regular"
//     scale_down_mode         = "Delete"
//     spot_max_price          = -1
//     ultra_ssd_enabled       = false
//     vm_size                 = "Standard_B2s"
//     vnet_subnet_id          = "/subscriptions/9b92b540-a481-460c-aeaf-9edb236a1481/resourceGroups/rg-infra-son-test/providers/Microsoft.Network/virtualNetworks/rginfrasontestvnet877/subnets/default"
//     zones                   = []

//     timeouts {}
    
//     tags                                = {
//         managed_by  = "Terraform"
//         environment = "dev"
//         team        = "Infra"
//         pool        = "windowspool"
//     }
// }
