resource "aws_api_gateway_rest_api" "api" {
  name = "${var.project_prefix}-api"
}

resource "aws_api_gateway_resource" "calls" {
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  parent_id   = "${aws_api_gateway_rest_api.api.root_resource_id}"
  path_part   = "calls"
}

resource "aws_api_gateway_method" "calls" {
  rest_api_id   = "${aws_api_gateway_rest_api.api.id}"
  resource_id   = "${aws_api_gateway_resource.calls.id}"
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_resource" "recordings" {
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  parent_id   = "${aws_api_gateway_rest_api.api.root_resource_id}"
  path_part   = "recordings"
}

resource "aws_api_gateway_method" "recordings" {
  rest_api_id   = "${aws_api_gateway_rest_api.api.id}"
  resource_id   = "${aws_api_gateway_resource.recordings.id}"
  http_method   = "POST"
  authorization = "NONE"
}

module "create_call_lambda" {
  source = "./modules/endpoint_lambda"

  name           = "createCall"
  project_prefix = "${var.project_prefix}"

  environment_variables = {
    API_URL                 = "https://gasz0p1vy4.execute-api.us-east-2.amazonaws.com/${var.api_stage}"
    API_SAVE_RECORDING_PATH = "${aws_api_gateway_resource.recordings.path}"
  }

  role_arn = "${aws_iam_role.lambda_allow_assume_role.arn}"

  region      = "${var.region}"
  api_id      = "${aws_api_gateway_rest_api.api.id}"
  resource_id = "${aws_api_gateway_resource.calls.id}"
  http_method = "${aws_api_gateway_method.calls.http_method}"
}

resource "aws_iam_role" "lambda_allow_assume_role" {
  name               = "${var.project_prefix}-lambda-allow-assume-role"
  assume_role_policy = "${module.lambda_trust_document.json}"
}

module "lambda_trust_document" {
  source = "../lambda_trust_document"
}

module "create_recording_lambda" {
  source = "./modules/endpoint_lambda"

  name           = "createRecording"
  project_prefix = "${var.project_prefix}"

  environment_variables = {
    RECORDINGS_S3_BUCKET_ID = "${var.recordings_s3_bucket_id}"
  }

  role_arn = "${module.role_for_recordings_uploads.arn}"

  region      = "${var.region}"
  api_id      = "${aws_api_gateway_rest_api.api.id}"
  resource_id = "${aws_api_gateway_resource.recordings.id}"
  http_method = "${aws_api_gateway_method.recordings.http_method}"
}

module "role_for_recordings_uploads" {
  source = "./modules/role_for_recordings_uploads"

  project_prefix = "${var.project_prefix}"
  bucket_arn     = "${var.recordings_s3_bucket_arn}"
}
