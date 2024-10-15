locals {
  gitlab_oidc_subject = var.gitlab_oidc_defaults != null ? "project_path:${try(var.gitlab_oidc_defaults.project_path, {})}:ref_type:${try(var.gitlab_oidc_defaults.ref_type, "")}:ref:${try(var.gitlab_oidc_defaults.ref_name, "")}" : ""
}

data "tls_certificate" "gitlab" {
  count = var.gitlab_oidc_defaults != null ? 1 : 0
  url   = var.gitlab_oidc_defaults.oidc_issuer
}

# AWS WIF
resource "aws_iam_openid_connect_provider" "gitlab" {
  count           = local.create_aws_wif && var.gitlab_oidc_defaults != null ? 1 : 0
  url             = var.gitlab_oidc_defaults.oidc_issuer
  client_id_list  = [var.gitlab_oidc_defaults.oidc_audience]
  thumbprint_list = [data.tls_certificate.gitlab[0].certificates[0].sha1_fingerprint]
}

data "aws_iam_openid_connect_provider" "gitlab" {
  count = (local.enable_aws_wif && !local.create_aws_wif && var.gitlab_oidc_defaults != null) ? 1 : 0
  url   = var.gitlab_oidc_defaults.oidc_issuer
}
