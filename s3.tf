resource "aws_s3_bucket" "main" {
  bucket = "laravel-tweet-ddd-public"
  acl    = "private"

  versioning {
      enabled = false
  }
}
