# Define the resources you want to create/manage with Terraform
module "subscription_id" {
  source = "./modules/subscriptions"
  env    = var.env
  region = var.region
}

locals {
  key    = "${var.env}-${var.region}"
  rgList = tolist(split(",", var.resourcegroup))
}

resource "azurerm_resource_group" "resourcegroupname" {
  count    = length(local.rgList)
  name     = trimspace(local.rgList[count.index])
  location = lookup(var.configuration, local.key, null)
  tags     = var.tags
}

data "azuread_user" "current" {
  user_principal_name = var.adminaccount
}

resource "azurerm_role_assignment" "contributor" {
  count                = length(local.rgList)
  scope                = azurerm_resource_group.resourcegroupname[count.index].id
  role_definition_name = "Contributor"
  principal_id         = data.azuread_user.current.object_id
}

resource "azurerm_role_assignment" "user_access_administrator" {
  count                = length(local.rgList)
  scope                = azurerm_resource_group.resourcegroupname[count.index].id
  role_definition_name = "User Access Administrator"
  principal_id         = data.azuread_user.current.object_id
}