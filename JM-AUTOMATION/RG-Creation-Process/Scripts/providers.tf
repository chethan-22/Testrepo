# Configure the Azure provider with the dynamic subscription_id
provider "azurerm" {
  skip_provider_registration = true
  subscription_id            = module.subscription_id.selected_subscription_id
  features {}
}

provider "azuread" {}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.95.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.0"
    }
  }
}