terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.37.0" #https://registry.terraform.io/providers/hashicorp/azurerm/latest
    }
  }
    backend "azurerm" {
        resource_group_name  = "rg-infra-dev"
        storage_account_name = "tfstatesc9qu"
        container_name       = "tfstate"
        key                  = "terraform_aks.tfstate"
    }

}

provider "azurerm" {
  features {}
  subscription_id   = "xxx" 
  tenant_id         = "xxx"
  client_id         = "xxx" 
  client_secret     = "xxx"
}
