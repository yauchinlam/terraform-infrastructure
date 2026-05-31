variable "github_owner" {
  description = "GitHub user or organization name for OIDC federated credential subject."
  type        = string
}

variable "github_repo_name" {
  description = "GitHub repository name used in resource naming."
  type        = string
  default     = "terraform-infrastructure"
}

variable "environment" {
  description = "Deployment environment suffix (for example, dev or prod)."
  type        = string
  default     = "dev"

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.environment))
    error_message = "Environment must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "location" {
  description = "Azure region for bootstrap resources."
  type        = string
}

variable "tags" {
  description = "Tags applied to all resources in this stack."
  type        = map(string)
  default = {
    repository  = "terraform-infrastructure"
    environment = "dev"
    managed_by  = "terraform"
  }
}
