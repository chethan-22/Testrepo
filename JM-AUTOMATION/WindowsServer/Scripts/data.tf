# Virtual Network
# Refer to an existing virtual network

data "azurerm_virtual_network" "existing" {
  name                = var.vnet
  resource_group_name = var.vnetRG
}

# Refer to an existing subnet within the virtual network
data "azurerm_subnet" "existing" {
  name                 = var.snet
  virtual_network_name = data.azurerm_virtual_network.existing.name
  resource_group_name  = var.vnetRG
}

