resource "azurerm_role_assignment" "deploy_contributor" {
  scope                = azurerm_resource_group.bootstrap.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.deploy.principal_id

  skip_service_aad_check = true
}

resource "azurerm_role_assignment" "deploy_tfstate_blob_contributor" {
  scope                = azurerm_storage_account.tfstate.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_user_assigned_identity.deploy.principal_id

  skip_service_aad_check = true
}
