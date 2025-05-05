data "azurerm_resource_group" "rg" {
  name = "RG-DEV-EU-EJM-002"
}
data "azurerm_client_config" "current" {
}