resource "azurerm_federated_identity_credential" "github_main" {
  name                = "fc-${var.github_repo_name}-${var.environment}-github-main"
  resource_group_name = azurerm_resource_group.bootstrap.name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = "https://token.actions.githubusercontent.com"
  parent_id           = azurerm_user_assigned_identity.deploy.id
  subject             = local.github_oidc_subject_main
}
