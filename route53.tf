resource "aws_route53_zone" "main" {
  name = var.domain
}

resource "aws_route53_record" "a_record" {
  zone_id = aws_route53_zone.main.zone_id
  name    = ""
  type    = "A"

  alias {
    name                   = aws_lb.main.dns_name
    zone_id                = aws_lb.main.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "validation" {
  depends_on = [aws_acm_certificate.main]
  zone_id    = aws_route53_zone.main.id
  name       = aws_acm_certificate.main.domain_validation_options.0.resource_record_name
  type       = "CNAME"
  records    = [aws_acm_certificate.main.domain_validation_options.0.resource_record_value]
  ttl        = 60
}
