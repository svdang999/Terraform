<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management.ext](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management) | resource |
| [azurerm_api_management.int](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_identity"></a> [identity](#input\_identity) | The name of the identity account | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The name of the region location | `string` | n/a | yes |
| <a name="input_min_api_version"></a> [min\_api\_version](#input\_min\_api\_version) | Minimum API version of APIM | `string` | n/a | yes |
| <a name="input_names_ext"></a> [names\_ext](#input\_names\_ext) | List of API Management external names | `list(string)` | n/a | yes |
| <a name="input_names_int"></a> [names\_int](#input\_names\_int) | List of API Management external names | `list(string)` | n/a | yes |
| <a name="input_network_virtual_network_subnet_id"></a> [network\_virtual\_network\_subnet\_id](#input\_network\_virtual\_network\_subnet\_id) | The name of the virtual network subnet | `string` | n/a | yes |
| <a name="input_publisher_email"></a> [publisher\_email](#input\_publisher\_email) | The email of the publisher account | `string` | n/a | yes |
| <a name="input_publisher_name"></a> [publisher\_name](#input\_publisher\_name) | The name of the publisher | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group | `string` | n/a | yes |
| <a name="input_resource_group_name_network"></a> [resource\_group\_name\_network](#input\_resource\_group\_name\_network) | The name of the network resource group | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The name of the APIM SKU | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_apim_ext_id"></a> [apim\_ext\_id](#output\_apim\_ext\_id) | A map of APIM external names and their IDs. |
| <a name="output_apim_int_id"></a> [apim\_int\_id](#output\_apim\_int\_id) | A map of APIM internal names and their IDs. |
<!-- END_TF_DOCS -->