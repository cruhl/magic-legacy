resource "aws_api_gateway_deployment" "api" {
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  stage_name  = "${var.stage}"
}

resource "aws_api_gateway_rest_api" "api" {
  name = "api"
}

resource "aws_api_gateway_resource" "calls" {
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  parent_id   = "${aws_api_gateway_rest_api.api.root_resource_id}"
  path_part   = "calls"
}

resource "aws_api_gateway_resource" "recordings" {
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  parent_id   = "${aws_api_gateway_rest_api.api.root_resource_id}"
  path_part   = "recordings"
}
