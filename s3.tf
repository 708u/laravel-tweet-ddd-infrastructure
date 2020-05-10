resource "aws_s3_bucket" "main" {
  bucket = "${var.project}-public"
  acl    = "private"

  versioning {
    enabled = false
  }
}
