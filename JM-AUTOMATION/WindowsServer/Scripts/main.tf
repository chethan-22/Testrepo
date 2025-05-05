
# Public IP Address
resource "azurerm_public_ip" "public_ip" {
  count               = var.public_ip_enabled ? 1 : 0
  name                = "${var.vmname}-public-ip"
  location            = var.location
  resource_group_name = var.resourcegroup
  allocation_method   = "Dynamic"
}

# Network Interface
resource "azurerm_network_interface" "nic" {
  name                = "${var.vmname}-nic"
  location            = var.location
  resource_group_name = var.resourcegroup

  ip_configuration {
    name                          = "ipconfig-${var.vmname}"
    subnet_id                     = data.azurerm_subnet.existing.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_enabled ? azurerm_public_ip.public_ip[0].id : null
  }
}

# Storage Account
#resource "azurerm_storage_account" "storage" {
#  name                     = "${lower(var.storage_account_name)}"
#  resource_group_name      = var.resourcegroup
#  location                 = var.location
#  account_tier             = "Standard"
#  account_replication_type = "LRS"
#}

# Virtual Machine
resource "azurerm_windows_virtual_machine" "vm" {
  name                  = var.vmname
  location              = var.location
  resource_group_name   = var.resourcegroup
  size                  = var.vmsize
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  network_interface_ids = [azurerm_network_interface.nic.id]

#  availability_set_id   = azurerm_availability_set.as.id

  os_disk {
    name              = "${var.vmname}-osdisk"
    disk_size_gb      = 128
    caching           = "ReadWrite"
    storage_account_type = var.os_disk_type
  }

  boot_diagnostics {
    storage_account_uri = null
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
  

  tags = var.tags
}

# Authentication Method
# Implement authentication method here (e.g., service principal, managed identity)

# Monitoring and Management
# Implement monitoring and automation settings here (e.g., Azure Monitor, Azure Automation)

# Advanced Settings
# Implement advanced settings here (e.g., availability zones, custom script extension)