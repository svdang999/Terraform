#Sample for create/import Terraform with Function App and App Service Plan
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.58.0" #https://registry.terraform.io/providers/hashicorp/azurerm/latest
    }
  }
    backend "azurerm" {
        resource_group_name  = "rg-test"
        storage_account_name = "storetest"
        container_name       = "terraform"
        key                  = "aurora.funcapp.fin.test.tfstate"
    }

}

provider "azurerm" {
  features {}
  subscription_id   = "xxx" # Dev_Test Pay-As-You-Go
  tenant_id         = "xxx" # Dev_Test Pay-As-You-Go Tenant
}


##https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_function_app
resource "azurerm_service_plan" "example" {
  name                = "appplan-linux-test"
  resource_group_name = "rg-test"
  location            = "germanywestcentral"
  os_type             = "Linux"

  maximum_elastic_worker_count = 1
  per_site_scaling_enabled     = false
  sku_name                     = "F1"
  tags = {
      managed_by  = "Terraform"
      environment = "Dev/Test"
      team        = "Infra"
      product     = "Aurora"
  }
  
}

resource "azurerm_linux_function_app" "example" {
    name                = "funcapp-fin-test" 
    resource_group_name = "rg-test"
    location            = "germanywestcentral"
    tags = {
      managed_by  = "Terraform"
      environment = "Dev/Test"
      team        = "Infra"
      product     = "Aurora"
    }    
}
