data "aws_iam_policy_document" "asset_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.assets.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.assets_origin_access_identity.iam_arn]
    }
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = ["${aws_s3_bucket.assets.arn}"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.assets_origin_access_identity.iam_arn]
    }
  }
}
