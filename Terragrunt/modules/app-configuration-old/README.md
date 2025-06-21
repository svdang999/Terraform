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
| <a name="module_app_pe"></a> [app\_pe](#module\_app\_pe) | git::ssh://git@github.com/SaudiPostLogisticsGroup/dbp-cloud-platform-sharedmodule-iac.git//networking/private-endpoint | main |

## Resources

| Name | Type |
|------|------|
| [azurerm_app_configuration.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_configuration) | resource |
| [azurerm_application_insights.npd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |
| [azurerm_log_analytics_workspace.npd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azuread_administrator_login_username"></a> [azuread\_administrator\_login\_username](#input\_azuread\_administrator\_login\_username) | n/a | `string` | n/a | yes |
| <a name="input_azuread_administrator_object_id"></a> [azuread\_administrator\_object\_id](#input\_azuread\_administrator\_object\_id) | n/a | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | n/a | yes |
| <a name="input_identity"></a> [identity](#input\_identity) | user identity | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_names"></a> [names](#input\_names) | list of app configuration names | `list(string)` | `[]` | no |
| <a name="input_platform"></a> [platform](#input\_platform) | n/a | `string` | n/a | yes |
| <a name="input_private_endpoint_name"></a> [private\_endpoint\_name](#input\_private\_endpoint\_name) | n/a | `string` | n/a | yes |
| <a name="input_private_endpoint_subnet"></a> [private\_endpoint\_subnet](#input\_private\_endpoint\_subnet) | name of private endpoint subnet | `string` | n/a | yes |
| <a name="input_private_endpoint_vnet"></a> [private\_endpoint\_vnet](#input\_private\_endpoint\_vnet) | n/a | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_resource_group_name_network"></a> [resource\_group\_name\_network](#input\_resource\_group\_name\_network) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | list of tags | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_configuration_id"></a> [app\_configuration\_id](#output\_app\_configuration\_id) | A map of app configurations and their IDs. |
<!-- END_TF_DOCS -->