resource "aws_ssm_parameter" "app_key" {
  name        = "/app/key"
  value       = "secret"
  type        = "SecureString"
  description = "app key for laravel"

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "db_password" {
  name        = "/db/password"
  value       = var.db_password
  type        = "SecureString"
  description = "db master password"

  lifecycle {
    ignore_changes = [value]
  }
}
