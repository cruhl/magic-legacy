output "recordings_s3_bucket_id" {
  value = "${aws_s3_bucket.recordings.id}"
}

output "recordings_s3_bucket_url" {
  value = "${aws_s3_bucket.recordings.bucket_domain_name}"
}
