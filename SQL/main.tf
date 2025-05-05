# Create SQL Server
resource "azurerm_mssql_server" "sql_server" {
    name                         = "my-sql-server"
    resource_group_name          = "my-resource-group"
    location                     = "West Europe"
    version                      = "12.0"
    administrator_login          = "sqladmin"
    administrator_login_password = "ComplexPassword1!"
    public_network_access_enabled = false
}

# Create SQL Database
resource "azurerm_mssql_database" "sql_database" {
    name           = "my-sql-database"
    server_id      = azurerm_mssql_server.sql_server.id
    sku_name       = "S0"
    max_size_gb    = 250
}

# Create Private Endpoint
resource "azurerm_private_endpoint" "sql_private_endpoint" {
    name                = "my-sql-private-endpoint"
    location            = "West Europe"
    resource_group_name = "my-resource-group"
    subnet_id           = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/my-resource-group/providers/Microsoft.Network/virtualNetworks/my-vnet/subnets/my-subnet"
  private_service_connection {
        name                           = "my-sql-private-service-connection"
        private_connection_resource_id = azurerm_mssql_server.sql_server.id
        subresource_names              = ["sqlServer"]
        is_manual_connection           = false
  }
}