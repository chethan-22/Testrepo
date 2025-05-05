provider "azurerm" {
  skip_provider_registration = true
  subscription_id            = var.subscription_id
  tenant_id                  = var.tenant_id
  features {
  }
}

terraform {
  backend "azurerm" {
    # variables are not allowed so file has to be transformed during CI/CD
    resource_group_name  = "#{Terraform-RG}#"
    storage_account_name = "stadevejmtf002"
    container_name       = "terraform"
    key                  = "#{Project-Name}#-#{Environment-Name}.terraform.tfstate"
  }
}


# Calculate Locals
locals {
  dns_prefix        = "eJMPOCDemo"
  containerRegistry = "ejmDemoACR"
}

# Create a Resource Group
resource "azurerm_resource_group" "aks_rg" {
  count    = var.create_resource_group ? 1 : 0
  name     = lower(var.resource_group_name)
  location = var.location
  tags     = merge(var.tags, { "Name" = var.resource_group_name }, )
}

# Create an AKS Cluster
resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = var.aks_cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = local.dns_prefix

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  tags = {
    Environment = "Dev"
  }
}
output "client_certificate" {
  value     = azurerm_kubernetes_cluster.aks_cluster.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw
  sensitive = true
}


####################### Create ACR #############################

resource "azurerm_container_registry" "acr" {
  name                = local.containerRegistry
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true
}
