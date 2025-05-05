# Create an Azure Storage Account
resource "azurerm_storage_account" "storage_account" {
  count                    = length(local.storageList)
  name                     = trimspace(local.storageList[count.index])
  resource_group_name      = var.resourcegroup_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}
