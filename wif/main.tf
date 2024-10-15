data "aws_iam_policy_document" "gitlab_assume_role_policy" {
  count = local.enable_aws_wif && var.gitlab_oidc_defaults != null ? 1 : 0

  statement {
    actions = [
      "sts:AssumeRoleWithWebIdentity",
    ]
    effect = "Allow"

    condition {
      test = "StringLike"
      values = [
        local.gitlab_oidc_subject
      ]
      variable = "${replace(var.gitlab_oidc_defaults.oidc_issuer, "https://", "")}:sub"
    }


    principals {
      identifiers = [local.aws_gitlab_provider.arn]
      type        = "Federated"
    }
  }

  version = "2012-10-17"
}

data "aws_iam_policy_document" "github_assume_role_policy" {
  count = local.enable_aws_wif && var.github_oidc_defaults != null ? 1 : 0

  statement {
    actions = [
      "sts:AssumeRoleWithWebIdentity",
    ]
    effect = "Allow"

    condition {
      test = "StringLike"
      values = [
        local.github_oidc_subject
      ]
      variable = "${replace(var.github_oidc_defaults.oidc_issuer, "https://", "")}:sub"
    }


    principals {
      identifiers = [local.aws_github_provider.arn]
      type        = "Federated"
    }
  }

  version = "2012-10-17"
}

data "aws_iam_policy_document" "assume_role" {
  count = local.enable_aws_wif ? 1 : 0
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
      "sts:AssumeRoleWithWebIdentity",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "assume_role" {
  count       = local.enable_aws_wif ? 1 : 0
  name        = var.aws_wif.policy_name
  description = "A policy for WIF role to assume other roles."
  policy      = data.aws_iam_policy_document.assume_role[0].json
}

resource "aws_iam_role" "gitlab" {
  count              = local.enable_aws_wif && var.gitlab_oidc_defaults != null ? 1 : 0
  name               = var.aws_wif.gitlab_role_name
  assume_role_policy = data.aws_iam_policy_document.gitlab_assume_role_policy[0].json
}

resource "aws_iam_role_policy_attachment" "gitlab" {
  count      = local.enable_aws_wif && var.gitlab_oidc_defaults != null ? 1 : 0
  role       = aws_iam_role.gitlab[0].name
  policy_arn = aws_iam_policy.assume_role[0].arn
}

resource "aws_iam_role" "github" {
  count              = local.enable_aws_wif && var.github_oidc_defaults != null ? 1 : 0
  name               = var.aws_wif.github_role_name
  assume_role_policy = data.aws_iam_policy_document.github_assume_role_policy[0].json
}

resource "aws_iam_role_policy_attachment" "github" {
  count      = local.enable_aws_wif && var.github_oidc_defaults != null ? 1 : 0
  role       = aws_iam_role.github[0].name
  policy_arn = aws_iam_policy.assume_role[0].arn
}

output "role_arn" {
  description = "Role arn that needs to be assumed by GitLab CI"
  value       = aws_iam_role.gitlab[0].arn
}
