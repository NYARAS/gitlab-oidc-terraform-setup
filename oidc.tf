resource "aws_iam_openid_connect_provider" "gitlab" {
  thumbprint_list = [data.tls_certificate.gitlab.certificates.0.sha1_fingerprint]

  client_id_list = [var.gitlab_url]
  url            = var.gitlab_url
}
