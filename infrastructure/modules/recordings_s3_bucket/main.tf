resource "aws_s3_bucket" "bucket" {
  bucket = "${var.project_prefix}-recordings"
}
