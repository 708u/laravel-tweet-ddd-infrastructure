resource "aws_ssm_parameter" "app_key" {
  name        = "/app/key"
  value       = "secret"
  type        = "SecureString"
  description = "app key for laravel"

  lifecycle {
    ignore_changes = [value]
  }
}
