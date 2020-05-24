resource "aws_ses_domain_identity" "ses" {
  domain   = var.domain
  provider = aws.virginia
}

resource "aws_ses_domain_dkim" "dkim" {
  domain   = var.domain
  provider = aws.virginia
}
