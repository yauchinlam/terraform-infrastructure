output "tenant_id" {
  description = "Azure AD tenant ID for GitHub Actions azure/login."
  value       = data.azurerm_client_config.current.tenant_id
  sensitive   = true
}

output "subscription_id" {
  description = "Azure subscription ID used by the provider for this run."
  value       = data.azurerm_client_config.current.subscription_id
}

output "resource_group_name" {
  description = "Name of the bootstrap resource group."
  value       = azurerm_resource_group.bootstrap.name
}

output "resource_group_id" {
  description = "Resource ID of the bootstrap resource group."
  value       = azurerm_resource_group.bootstrap.id
}

output "tfstate_storage_account_name" {
  description = "Storage account name for Terraform remote state."
  value       = azurerm_storage_account.tfstate.name
}

output "tfstate_storage_account_id" {
  description = "Resource ID of the Terraform state storage account."
  value       = azurerm_storage_account.tfstate.id
}

output "tfstate_container_name" {
  description = "Blob container name used for Terraform state files."
  value       = azurerm_storage_container.tfstate.name
}

output "deploy_identity_name" {
  description = "Name of the user-assigned managed identity for deployments."
  value       = azurerm_user_assigned_identity.deploy.name
}

output "deploy_identity_client_id" {
  description = "Client ID of the deployment managed identity (for GitHub Actions OIDC)."
  value       = azurerm_user_assigned_identity.deploy.client_id
}

output "deploy_identity_principal_id" {
  description = "Principal ID of the deployment managed identity (for RBAC assignments)."
  value       = azurerm_user_assigned_identity.deploy.principal_id
}

output "github_oidc_subject_main" {
  description = "OIDC subject trusted for deployments from the main branch."
  value       = local.github_oidc_subject_main
}
