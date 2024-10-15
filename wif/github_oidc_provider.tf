locals {
  github_oidc_ref_type = (
    try(var.github_oidc_defaults.ref_type, "") == "branch" ? "branch" :
    try(var.github_oidc_defaults.ref_type, "") == "tag" ? "tag" : ""
  )
  github_oidc_ref_name = var.github_oidc_defaults != null ? try(var.github_oidc_defaults.ref_name, "") : ""
  github_oidc_ref_string = (
    local.github_oidc_ref_type == "branch" ? "ref:refs/heads/${local.github_oidc_ref_name}" :
    local.github_oidc_ref_type == "tag" ? "ref:refs/tags/${local.github_oidc_ref_name}" : ""
  )
  github_oidc_subject = var.github_oidc_defaults != null ? "repo:${try(var.github_oidc_defaults.repository_path, {})}:${local.github_oidc_ref_string}" : ""
}

data "tls_certificate" "github" {
  count = var.github_oidc_defaults != null ? 1 : 0
  url   = var.github_oidc_defaults.oidc_issuer
}

# AWS WIF
resource "aws_iam_openid_connect_provider" "github" {
  count           = local.create_aws_wif && var.github_oidc_defaults != null ? 1 : 0
  url             = var.github_oidc_defaults.oidc_issuer
  client_id_list  = [var.github_oidc_defaults.oidc_audience]
  thumbprint_list = [data.tls_certificate.github[0].certificates[0].sha1_fingerprint]
}

data "aws_iam_openid_connect_provider" "github" {
  count = (local.enable_aws_wif && !local.create_aws_wif && var.github_oidc_defaults != null) ? 1 : 0
  url   = var.github_oidc_defaults.oidc_issuer
}
