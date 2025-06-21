locals {
  subscription_id_devops                              = "4413e1f9-5c85-4fe3-ac08-e4471945ea01" 
  subscription_id_management                          = "7d67f956-2120-4459-8ad9-8745ff210df9" 
  subscription_id_connectivity                        = "fdea6769-b01e-4a30-a3c6-dd170eb79a22" 
  subscription_id_integration_npd                     = "f325afb1-2e02-41d8-8c9b-f13102eebe4a" 
  deployment_storage_resource_group_name              = "rg-splg-devops-ger-01"
  tenant_id_spl                                       = "ca4b9986-c729-4ee0-a5be-39c116865241" 
  deployment_storage_account_name                     = "stdevopstfstateger01"
  container_name                                      = "terragrunt-tfstate"

  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("env_region.hcl"))
}

remote_state {
  backend = "azurerm"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    subscription_id      = local.subscription_id_devops
    tenant_id            = local.tenant_id_spl
    resource_group_name  = local.deployment_storage_resource_group_name
    storage_account_name = local.deployment_storage_account_name
    container_name       = local.container_name
    key                  = "${path_relative_to_include()}/terraform.tfstate"
    use_oidc             = true
  }
}


# Generate Azure providers
generate "providers" {
  path      = "terraform.providers.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
    terraform {
      required_providers {
        azurerm = {
          source = "hashicorp/azurerm"
          version = "~> 4.32"
        }
      }
    }    

    provider "azurerm" {
        alias           = "management"
        subscription_id = "${local.subscription_id_management}"
        use_oidc        = true
        features {}
    }

    provider "azurerm" {
        #alias           = "integration non-prd"
        subscription_id   = "${local.subscription_id_integration_npd}"
        use_oidc          = true
        features {}
    }

    provider "azurerm" {
        alias             = "connectivity"
        subscription_id   = "${local.subscription_id_connectivity}"
        use_oidc          = true
        features {}
    }
EOF
}