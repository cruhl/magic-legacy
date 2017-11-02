output "id" {
  value = "${aws_api_gateway_rest_api.api.id}"
}

output "url" {
  value = "${aws_api_gateway_deployment.api.invoke_url}"
}

output "recordings_path" {
  value = "${aws_api_gateway_resource.recordings.path}"
}

output "calls_resource_id" {
  value = "${aws_api_gateway_resource.calls.id}"
}

output "recordings_resource_id" {
  value = "${aws_api_gateway_resource.recordings.id}"
}
