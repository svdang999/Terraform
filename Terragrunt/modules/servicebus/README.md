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
| [azurerm_eventhub_namespace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace) | resource |
| [azurerm_servicebus_namespace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azuread_administrator_login_username"></a> [azuread\_administrator\_login\_username](#input\_azuread\_administrator\_login\_username) | n/a | `string` | n/a | yes |
| <a name="input_azuread_administrator_object_id"></a> [azuread\_administrator\_object\_id](#input\_azuread\_administrator\_object\_id) | n/a | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | n/a | yes |
| <a name="input_identity"></a> [identity](#input\_identity) | user identity | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | #General vars | `string` | n/a | yes |
| <a name="input_names"></a> [names](#input\_names) | n/a | `list(string)` | <pre>[<br/>  "servicebus010"<br/>]</pre> | no |
| <a name="input_platform"></a> [platform](#input\_platform) | n/a | `string` | n/a | yes |
| <a name="input_private_endpoint_name"></a> [private\_endpoint\_name](#input\_private\_endpoint\_name) | n/a | `string` | n/a | yes |
| <a name="input_private_endpoint_subnet"></a> [private\_endpoint\_subnet](#input\_private\_endpoint\_subnet) | n/a | `string` | n/a | yes |
| <a name="input_private_endpoint_vnet"></a> [private\_endpoint\_vnet](#input\_private\_endpoint\_vnet) | n/a | `string` | n/a | yes |
| <a name="input_region_short"></a> [region\_short](#input\_region\_short) | n/a | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_resource_group_name_network"></a> [resource\_group\_name\_network](#input\_resource\_group\_name\_network) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eventhub_namespace_id"></a> [eventhub\_namespace\_id](#output\_eventhub\_namespace\_id) | Azure Event Hub id |
| <a name="output_servicebus_namespace_id"></a> [servicebus\_namespace\_id](#output\_servicebus\_namespace\_id) | Azure Service Bus id |
<!-- END_TF_DOCS -->