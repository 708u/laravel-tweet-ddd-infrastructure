resource "aws_cloudfront_origin_access_identity" "assets_origin_access_identity" {
  comment = "CloudFront Origin Access Identity"
}

resource "aws_cloudfront_distribution" "assets" {
  origin {
    domain_name = aws_s3_bucket.assets.bucket_domain_name
    origin_id   = "${var.project}-assets"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.assets_origin_access_identity.cloudfront_access_identity_path
    }
  }

  enabled         = true
  is_ipv6_enabled = true
  comment         = "${var.project} assets."

  default_root_object = "index.html"

  aliases = ["cdn.${var.domain}"]

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.cdn.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2018"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  default_cache_behavior {
    compress               = true
    viewer_protocol_policy = "allow-all"
    default_ttl            = 86400
    min_ttl                = 0
    max_ttl                = 31536000
    allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "${var.project}-assets"

    forwarded_values {
      query_string = true
      headers      = ["Origin"]

      cookies {
        forward = "none"
      }
    }
  }

  tags = {
    Name = "${var.project}-cloudfront-distribution"
  }
}
