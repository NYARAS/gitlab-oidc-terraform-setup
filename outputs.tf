output "role_arn" {
  description = "Role arn that needs to be assumed by GitLab CI"
  value       = aws_iam_role.gitlab_ci.arn
}
