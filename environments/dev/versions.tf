terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  # Bootstrap stack: use local state for the first apply.
  # After the storage account exists, migrate state to the azurerm backend
  # defined in backend.tf.example.
}

provider "azurerm" {
  features {}

  use_oidc            = true
  storage_use_azuread = true
}
