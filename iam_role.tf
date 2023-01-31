resource "aws_iam_role" "gitlab_ci" {
  name               = var.role_name
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "${aws_iam_openid_connect_provider.gitlab.arn}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "gitlab.com:sub": "project_path:${var.gitlab_group}/${var.gitlab_subgroup}/${var.gitlab_project}:ref_type:branch:ref:${var.gitlab_branch}"
        }
      }
    }
  ]
}
EOF
}
