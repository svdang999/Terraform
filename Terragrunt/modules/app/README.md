<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_azurerm.management"></a> [azurerm.management](#provider\_azurerm.management) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_func_pe"></a> [func\_pe](#module\_func\_pe) | git::ssh://git@github.com/SaudiPostLogisticsGroup/dbp-cloud-platform-sharedmodule-iac.git//networking/private-endpoint | main |

## Resources

| Name | Type |
|------|------|
| [azurerm_service_plan.win](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) | resource |
| [azurerm_windows_function_app.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_function_app) | resource |
| [azurerm_application_insights.npd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_log_analytics_workspace.npd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_service_plan_name"></a> [app\_service\_plan\_name](#input\_app\_service\_plan\_name) | The name of the App Service Plan | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The name of the environment dev/uat/prd | `string` | n/a | yes |
| <a name="input_identity"></a> [identity](#input\_identity) | The name of the identity account | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The name of the region location | `string` | n/a | yes |
| <a name="input_logs_destinations_id"></a> [logs\_destinations\_id](#input\_logs\_destinations\_id) | The name of the diagnostic logs | `string` | n/a | yes |
| <a name="input_names"></a> [names](#input\_names) | List of function app names | `list(string)` | `[]` | no |
| <a name="input_network_subnet_app"></a> [network\_subnet\_app](#input\_network\_subnet\_app) | The name of the app subnet | `string` | n/a | yes |
| <a name="input_network_virtual_network_subnet_id"></a> [network\_virtual\_network\_subnet\_id](#input\_network\_virtual\_network\_subnet\_id) | The name of the virtual network subnet | `string` | n/a | yes |
| <a name="input_network_vnet_name"></a> [network\_vnet\_name](#input\_network\_vnet\_name) | The name of the vnet | `string` | n/a | yes |
| <a name="input_platform"></a> [platform](#input\_platform) | The name of the platform i.e intgp/logsp | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group | `string` | n/a | yes |
| <a name="input_resource_group_name_network"></a> [resource\_group\_name\_network](#input\_resource\_group\_name\_network) | The name of the network resource group | `string` | n/a | yes |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | The name of the storage account | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | the name of tags list | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_id"></a> [app\_id](#output\_app\_id) | A map of app names and their IDs. |
<!-- END_TF_DOCS -->