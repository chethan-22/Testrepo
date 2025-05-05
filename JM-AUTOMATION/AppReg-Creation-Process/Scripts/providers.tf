terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.47.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.96.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true
  features {
  }
}

provider "azuread" {
  tenant_id = "cc7f83dd-bc5a-4682-9b3e-062a900202a2"
}