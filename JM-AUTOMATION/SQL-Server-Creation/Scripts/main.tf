resource "azurerm_mssql_server" "sqlsr" {
#  count                        = length(var.regions)
  name                         = var.mssql_server_name
  resource_group_name          = var.resourcegroup_name
  location                     = var.location
  version                      = var.sql_version
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
  #tags                         = var.tags
}

resource "azurerm_mssql_database" "sqldb" {
  #count                            = var.mssql_database_required == true ? length(var.mssql_db_name) : 0
  name                             = var.mssql_db_name
  server_id                        = azurerm_mssql_server.sqlsr.id
  sku_name                          = var.sku_name 
  #requested_service_objective_name = var.requested_service_objective_name
  #tags                             = var.tags
 
}
