variable "tags" {
  description = "A mapping of tags/labels which should be assigned to resources."
  type        = map(string)
  default     = null
}

variable "aws_wif" {
  description = "Configuration block to configure AWS Workload Identity Federation."
  type = object({
    gitlab_role_name = optional(string, "gitlab-wif-role")
    github_role_name = optional(string, "github-wif-role")
    policy_name      = optional(string, "wif-assume-role-policy")
    create_new       = optional(bool, true)
  })
  default = null
}

variable "gitlab_oidc_defaults" {
  description = "A map of default Gitlab OIDC configuration."
  type = object({
    oidc_name      = optional(string, "gitlab")
    oidc_issuer    = optional(string, "https://gitlab.com")
    oidc_audience  = optional(string, "https://gitlab.com")
    namespace_path = optional(string)
    namespace_id   = optional(string)
    project_id     = optional(string)
    project_path   = string
    ref_type       = optional(string, "branch")
    ref_name       = optional(string, "main")
  })
  default = null
}

variable "github_oidc_defaults" {
  description = "A map of default Github OIDC configuration."
  type = object({
    oidc_name       = optional(string, "github")
    oidc_issuer     = optional(string, "https://token.actions.githubusercontent.com")
    oidc_audience   = optional(string, "https://github.com")
    organization    = optional(string, "")
    repository_path = string
    repository_id   = optional(string)
    ref_type        = optional(string, "branch")
    ref_name        = optional(string, "main")
  })
  default = null
}
