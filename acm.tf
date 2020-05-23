resource "aws_acm_certificate" "main" {
  domain_name       = "*.${var.domain}"
  validation_method = "DNS"

  subject_alternative_names = [var.domain]

  tags = {
    Name = "${var.project}-cert"
  }
}

resource "aws_acm_certificate" "cdn" {
  domain_name       = "*.${var.domain}"
  validation_method = "DNS"
  provider          = aws.virginia

  subject_alternative_names = [var.domain]

  tags = {
    Name = "${var.project}-cdn-cert"
  }
}
