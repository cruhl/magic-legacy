output "id" {
  value = "${aws_api_gateway_rest_api.api.id}"
}

output "recordings_path" {
  value = "${aws_api_gateway_resource.recordings.path}"
}

output "calls_resource_id" {
  value = "${aws_api_gateway_resource.calls.id}"
}

output "calls_http_method" {
  value = "${aws_api_gateway_method.calls.http_method}"
}

output "recordings_resource_id" {
  value = "${aws_api_gateway_resource.recordings.id}"
}

output "recordings_http_method" {
  value = "${aws_api_gateway_method.recordings.http_method}"
}
