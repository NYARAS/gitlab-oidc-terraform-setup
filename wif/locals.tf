locals {
  # AWS WIF
  enable_aws_wif      = var.aws_wif != null ? true : false
  create_aws_wif      = try(var.aws_wif.create_new, false)
  aws_gitlab_provider = local.enable_aws_wif && local.create_aws_wif ? try(aws_iam_openid_connect_provider.gitlab[0], null) : try(data.aws_iam_openid_connect_provider.gitlab[0], null)
  aws_github_provider = local.enable_aws_wif && local.create_aws_wif ? try(aws_iam_openid_connect_provider.github[0], null) : try(data.aws_iam_openid_connect_provider.github[0], null)

}
