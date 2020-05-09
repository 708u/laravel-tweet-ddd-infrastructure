resource "aws_acm_certificate" "main" {
  domain_name       = "*.${var.domain}"
  validation_method = "DNS"

  subject_alternative_names = [var.domain]

  lifecycle {
    create_before_destroy = false
  }

  tags = {
    Name = "${var.project}-cert"
  }
}
