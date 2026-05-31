terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-infrastructure-dev"
    storage_account_name = "stterraforminfrastructur"
    container_name       = "tfstate"
    key                  = "bootstrap/dev.tfstate"
    use_azuread_auth     = true
    use_oidc             = true
  }
}
