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
| [azurerm_network_security_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_subnet_network_security_group_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | The name of the region location | `string` | n/a | yes |
| <a name="input_names"></a> [names](#input\_names) | List of NSG names | `list(string)` | `[]` | no |
| <a name="input_network_virtual_network_subnet_id"></a> [network\_virtual\_network\_subnet\_id](#input\_network\_virtual\_network\_subnet\_id) | The name of the virtual network subnet | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group | `string` | n/a | yes |
| <a name="input_resource_group_name_network"></a> [resource\_group\_name\_network](#input\_resource\_group\_name\_network) | The name of the network resource group | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | General vars | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_network_security_group_id"></a> [network\_security\_group\_id](#output\_network\_security\_group\_id) | A map of NSG names and their IDs. |
<!-- END_TF_DOCS -->