locals {
  resource_group_name = "rg-${var.github_repo_name}-${var.environment}"

  # Storage account names must be 3-24 chars, lowercase alphanumeric, globally unique.
  storage_account_name = substr(
    replace("st${var.github_repo_name}${var.environment}", "-", ""),
    0,
    24
  )

  tfstate_container_name = "tfstate"
  deploy_identity_name   = "id-${var.github_repo_name}-${var.environment}-deploy"

  github_oidc_subject_main = "repo:${var.github_owner}/${var.github_repo_name}:ref:refs/heads/main"

  tags = merge(
    var.tags,
    {
      repository  = var.github_repo_name
      environment = var.environment
    }
  )
}
