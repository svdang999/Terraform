Module for import existing resource on Azure to Terraform

1. Import existing infrastructure to Terraform's state
    az account set --subscription "xxx"
    ```
    terraform.exe init
    terraform.exe import "azurerm_kubernetes_cluster.aks_import" "/subscriptions/9b92b540-a481-460c-aeaf-9edb236a1481/resourceGroups/rg-infra-son-test/providers/Microsoft.ContainerService/managedClusters/aks-infra-dev"
    ```
    
    List the state
    ```
    terraform state list    
    terraform state show 'azurerm_kubernetes_cluster.aks_import'    
    ```
2. Write configuration (tf file) that matches that infrastructure
    ```
    terraform plan
    ```
    
3. Reviews & apply
    ```
    terraform plan -out main.tfplan
    terraform apply "main.tfplan"
    ```
    
