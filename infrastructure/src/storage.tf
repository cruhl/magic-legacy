resource "aws_s3_bucket" "recordings" {
  bucket = "${var.project_prefix}-recordings"
}
