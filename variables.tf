variable "gitlab_group" {
  type = string
  description = "Gitlab group name"
  default = "calvine-devops"
}

variable "gitlab_subgroup" {
  type = string
  description = "Gitlab subgroup name"
  default = "aws"
}

variable "gitlab_project" {
  type = string
  description = "Gitlab project name"
  default = "terraform-eks-with-argocd"
}

variable "gitlab_branch" {
  type = string
  description = "Gitlab project branch name"
  default = "feature/oidc-test"
}

variable "gitlab_url" {
    type = string
  description = "Gitlab url"
  default = "https://gitlab.com"
}

variable "role_name" {
  type = string
  description = "Gitlab iam role name"
  default = "gitlab-ci"
}
