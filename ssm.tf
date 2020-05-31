variable "app_key" {}
resource "aws_ssm_parameter" "app_key" {
  name        = "/app/key"
  type        = "SecureString"
  description = "app key for laravel"
  key_id      = aws_kms_key.app.id
  value       = var.app_key

  lifecycle {
    ignore_changes = [value]
  }
}

variable "db_password" {}
resource "aws_ssm_parameter" "db_password" {
  name        = "/db/password"
  type        = "SecureString"
  description = "db master password"
  key_id      = aws_kms_key.app.id
  value       = var.db_password

  lifecycle {
    ignore_changes = [value]
  }
}

variable "slack_webhook_url" {}
resource "aws_ssm_parameter" "slack_webhook_url" {
  name        = "/app/slack-webhook-url"
  type        = "SecureString"
  description = "Slack webhook url"
  key_id      = aws_kms_key.app.id
  value       = var.slack_webhook_url

  lifecycle {
    ignore_changes = [value]
  }
}
