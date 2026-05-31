resource "azurerm_federated_identity_credential" "github_main" {
  name      = "fc-${var.github_repo_name}-${var.environment}-github-main"
  parent_id = azurerm_user_assigned_identity.deploy.id
  audience  = ["api://AzureADTokenExchange"]
  issuer    = "https://token.actions.githubusercontent.com"
  subject   = local.github_oidc_subject_main
}
