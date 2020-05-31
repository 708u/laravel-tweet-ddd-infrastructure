resource "aws_s3_bucket" "main" {
  bucket = "${var.project}-public"
  acl    = "private"

  versioning {
    enabled = false
  }
}
resource "aws_s3_bucket" "assets" {
  bucket = "${var.project}-assets"
  acl    = "private"

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["https://${var.domain}"]
    expose_headers  = ["ETag"]
    max_age_seconds = 4000
  }
}

resource "aws_s3_bucket_policy" "assets_policy" {
  bucket = aws_s3_bucket.assets.id
  policy = data.aws_iam_policy_document.asset_policy.json
}
