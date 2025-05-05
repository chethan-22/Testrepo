data "azuread_client_config" "current" {}

data "azuread_group" "devops-user-group" {
  display_name     = "DevOps-AccessGroup-JM-G"
  security_enabled = true
}