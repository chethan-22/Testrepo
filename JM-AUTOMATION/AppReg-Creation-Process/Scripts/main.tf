resource "azuread_application" "create-app-registration" {
  display_name = "AD-APP-${upper(var.environment)}-${upper(var.project)}-001"
  owners       = concat([data.azuread_client_config.current.object_id], data.azuread_group.devops-user-group.members)
}

resource "azuread_service_principal" "create-service-principal" {
  count                        = local.rbac-enabled ? 1 : 0
  client_id                    = azuread_application.create-app-registration.client_id
  app_role_assignment_required = false
  use_existing                 = true
  owners                       = concat([data.azuread_client_config.current.object_id], data.azuread_group.devops-user-group.members)
}


resource "azuread_application_federated_identity_credential" "github-federated-creadential" {
  count          = local.github-federated ? 1 : 0
  application_id = azuread_application.create-app-registration.id
  display_name   = "${lower(var.project)}-github-credential-${trimspace(lower(var.github-environment))}"
  description    = "Lets github actions connect to ${trimspace(var.github-environment)} azure resources."
  audiences      = ["api://AzureADTokenExchange"]
  issuer         = "https://token.actions.githubusercontent.com"
  subject        = "repo:johnsonmatthey/${trimspace(var.github-repo)}:environment:${trimspace(var.github-environment)}"
}

resource "azurerm_role_assignment" "role_assignment" {
  count                = length(local.combined_list)
  role_definition_name = trimspace(local.combined_list[count.index].role)
  scope                = trimspace(local.combined_list[count.index].scope)
  principal_id         = azuread_service_principal.create-service-principal[0].object_id
}

output "service_principal_client_id" {
  value = try(azuread_service_principal.create-service-principal[0].client_id, "")
}
