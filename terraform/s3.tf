resource "aws_s3_bucket" "data" {
  bucket = "${var.project}-data-bucket"
  force_destroy = true
}
