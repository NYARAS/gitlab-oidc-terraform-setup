variable "gitlab_group" {
  type = string
  description = "Gitlab group name"
  default = "calvine-devops"
}

variable "gitlab_subgroup" {
  type = string
  description = "Gitlab subgroup name"
  default = "gitops-argocd-demo"
}

variable "gitlab_project" {
  type = string
  description = "Gitlab project name"
  default = "*"
}

variable "gitlab_branch" {
  type = string
  description = "Gitlab project branch name"
  default = "*"
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
