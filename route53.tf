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

resource "aws_route53_record" "cdn_alias" {
  zone_id = aws_route53_zone.main.id
  name    = "cdn.${var.domain}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.assets.domain_name
    zone_id                = aws_cloudfront_distribution.assets.hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "ses_txt_record" {
  zone_id = aws_route53_zone.main.id
  name    = "_amazonses.${aws_route53_zone.main.name}"
  type    = "TXT"
  ttl     = "600"
  records = [aws_ses_domain_identity.ses.verification_token]
}

resource "aws_route53_record" "ses_dkim_records" {
  count   = 3
  zone_id = aws_route53_zone.main.id
  name    = "${element(aws_ses_domain_dkim.dkim.dkim_tokens, count.index)}._domainkey.${var.domain}"
  type    = "CNAME"
  ttl     = "600"
  records = ["${element(aws_ses_domain_dkim.dkim.dkim_tokens, count.index)}.dkim.amazonses.com"]
}

resource "aws_route53_record" "validation" {
  depends_on = [aws_acm_certificate.main]
  zone_id    = aws_route53_zone.main.id
  name       = aws_acm_certificate.main.domain_validation_options.0.resource_record_name
  type       = "CNAME"
  records    = [aws_acm_certificate.main.domain_validation_options.0.resource_record_value]
  ttl        = 60

  allow_overwrite = true
}

resource "aws_route53_record" "cdn_validation" {
  depends_on = [aws_acm_certificate.cdn]
  zone_id    = aws_route53_zone.main.id
  name       = aws_acm_certificate.cdn.domain_validation_options.1.resource_record_name
  type       = "CNAME"
  records    = [aws_acm_certificate.cdn.domain_validation_options.1.resource_record_value]
  ttl        = 60

  allow_overwrite = true
}
