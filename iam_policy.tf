locals {
  bucket_name = "devops-demo.tfstate"
}

resource "aws_iam_role_policy" "gitlab_ci" {
  name   = "s3"
  role   = aws_iam_role.gitlab_ci.name
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject"
      ],
      "Resource": "arn:aws:s3:::${local.bucket_name}/*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket"
      ],
      "Resource": "arn:aws:s3:::${local.bucket_name}"
    }
  ]
}
EOF
}
