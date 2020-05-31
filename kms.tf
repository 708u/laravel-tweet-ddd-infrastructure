resource "aws_kms_key" "app" {
  description = "The key that encrypt sensitive data."
}
