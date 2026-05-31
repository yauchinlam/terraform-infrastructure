resource "azurerm_resource_group" "bootstrap" {
  name     = local.resource_group_name
  location = var.location
  tags     = local.tags
}

resource "azurerm_storage_account" "tfstate" {
  name                = local.storage_account_name
  resource_group_name = azurerm_resource_group.bootstrap.name
  location            = azurerm_resource_group.bootstrap.location

  account_tier             = "Standard"
  account_replication_type = "LRS"

  # Transport and identity-based access (no shared keys; backend uses use_azuread_auth)
  min_tls_version                 = "TLS1_2"
  https_traffic_only_enabled      = true
  shared_access_key_enabled       = false
  default_to_oauth_authentication = true

  # Blob and account exposure
  allow_nested_items_to_be_public = false
  cross_tenant_replication_enabled = false

  # Disable alternate access paths not needed for Terraform state
  local_user_enabled = false
  nfsv3_enabled      = false
  sftp_enabled       = false

  # Encryption at rest (platform-managed keys; infrastructure encryption adds a second layer)
  infrastructure_encryption_enabled = true

  blob_properties {
    versioning_enabled       = true
    change_feed_enabled      = true
    last_access_time_enabled = false

    delete_retention_policy {
      days                     = 30
      permanent_delete_enabled = false
    }

    container_delete_retention_policy {
      days = 30
    }
  }

  tags = local.tags
}

resource "azurerm_management_lock" "tfstate" {
  name       = "tfstate-storage-delete-lock"
  scope      = azurerm_storage_account.tfstate.id
  lock_level = "CanNotDelete"
  notes      = "Prevent accidental deletion of the Terraform remote state storage account."
}

resource "azurerm_storage_container" "tfstate" {
  name                  = local.tfstate_container_name
  storage_account_id    = azurerm_storage_account.tfstate.id
  container_access_type = "private"
}

resource "azurerm_user_assigned_identity" "deploy" {
  name                = local.deploy_identity_name
  location            = azurerm_resource_group.bootstrap.location
  resource_group_name = azurerm_resource_group.bootstrap.name
  tags                = local.tags
}
