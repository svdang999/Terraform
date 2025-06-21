<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_sql-pe"></a> [sql-pe](#module\_sql-pe) | git::ssh://git@github.com/SaudiPostLogisticsGroup/dbp-cloud-platform-sharedmodule-iac.git//networking/private-endpoint | main |
| <a name="module_sql_database"></a> [sql\_database](#module\_sql\_database) | git::ssh://git@github.com/SaudiPostLogisticsGroup/dbp-cloud-platform-sharedmodule-iac.git//databases/sql-database | main |

## Resources

| Name | Type |
|------|------|
| [azurerm_mssql_elasticpool.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_elasticpool) | resource |
| [azurerm_mssql_server.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azuread_administrator_login_username"></a> [azuread\_administrator\_login\_username](#input\_azuread\_administrator\_login\_username) | n/a | `string` | n/a | yes |
| <a name="input_azuread_administrator_object_id"></a> [azuread\_administrator\_object\_id](#input\_azuread\_administrator\_object\_id) | n/a | `string` | n/a | yes |
| <a name="input_db_identity"></a> [db\_identity](#input\_db\_identity) | databases user identity | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_private_endpoint_name"></a> [private\_endpoint\_name](#input\_private\_endpoint\_name) | n/a | `string` | n/a | yes |
| <a name="input_private_endpoint_subnet"></a> [private\_endpoint\_subnet](#input\_private\_endpoint\_subnet) | n/a | `string` | n/a | yes |
| <a name="input_private_endpoint_vnet"></a> [private\_endpoint\_vnet](#input\_private\_endpoint\_vnet) | n/a | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_resource_group_name_network"></a> [resource\_group\_name\_network](#input\_resource\_group\_name\_network) | n/a | `string` | n/a | yes |
| <a name="input_sql_server_name"></a> [sql\_server\_name](#input\_sql\_server\_name) | n/a | `string` | n/a | yes |
| <a name="input_sql_server_name_elasticpool"></a> [sql\_server\_name\_elasticpool](#input\_sql\_server\_name\_elasticpool) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azurerm_mssql_elasticpool_id"></a> [azurerm\_mssql\_elasticpool\_id](#output\_azurerm\_mssql\_elasticpool\_id) | Azure SQL Elastic Pool id |
| <a name="output_azurerm_mssql_server_id"></a> [azurerm\_mssql\_server\_id](#output\_azurerm\_mssql\_server\_id) | Azure SQL Server id |
| <a name="output_mssql_databases_id"></a> [mssql\_databases\_id](#output\_mssql\_databases\_id) | Azure SQL databases ids |
<!-- END_TF_DOCS -->