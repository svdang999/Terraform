# output "azurerm_mssql_server_id" {
#   value       = var.names_server
#   description = "Azure SQL Server id"
# }

# output "azurerm_mssql_elasticpool_id" {
#   value       = azurerm_mssql_elasticpool.this.*.id
#   description = "Azure SQL Elastic Pool id"
# }

# output "mssql_databases_id" {
#   value       = module.sql_database.database_ids # module's outputs.tf folder
#   description = "Azure SQL databases ids"
# }

output "resource_group_name" {
  value       = var.resource_group_name
  description = "Azure Resource Group name"
}

output "location" {
  value       = var.location
  description = "location name"
}