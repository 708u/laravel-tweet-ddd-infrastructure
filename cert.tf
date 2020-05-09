resource "aws_acm_certificate" "main" {
  domain_name       = var.domain
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = false
  }

  tags = {
    Name = "${var.project}-cert"
  }
}
