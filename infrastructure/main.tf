provider "aws" {
  region = "${var.region}"
}

resource "aws_s3_bucket" "recordings" {
  bucket = "${var.project_prefix}-recordings"
}

data "aws_iam_policy_document" "recordings_upload_policy_document" {
  statement {
    effect    = "Allow"
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.recordings.arn}"]
  }
}

resource "aws_api_gateway_deployment" "api" {
  depends_on = [
    "module.incoming_twilio_call",
    "module.save_twilio_call",
  ]

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

module "incoming_twilio_call" {
  source = "./modules/endpoint"

  name        = "incoming-twilio-call"
  handler     = "index.incomingTwilioCall"
  http_method = "POST"

  environment_variables = {
    API_URL             = "https://vnetkniiah.execute-api.us-east-2.amazonaws.com/${var.stage}"
    SAVE_RECORDING_PATH = "${aws_api_gateway_resource.recordings.path}"
  }

  source_hash = "${data.archive_file.lambda_zip_file.output_base64sha256}"

  region        = "${var.region}"
  api_id        = "${aws_api_gateway_rest_api.api.id}"
  resource_id   = "${aws_api_gateway_resource.calls.id}"
  resource_path = "${aws_api_gateway_resource.calls.path}"
  role_arn      = "${aws_iam_role.lambda_role.arn}"
}

resource "aws_api_gateway_resource" "recordings" {
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  parent_id   = "${aws_api_gateway_rest_api.api.root_resource_id}"
  path_part   = "recordings"
}

module "save_twilio_call" {
  source = "./modules/endpoint"

  name        = "save-twilio-call"
  handler     = "index.saveTwilioCall"
  http_method = "POST"

  source_hash = "${data.archive_file.lambda_zip_file.output_base64sha256}"

  region        = "${var.region}"
  api_id        = "${aws_api_gateway_rest_api.api.id}"
  resource_id   = "${aws_api_gateway_resource.recordings.id}"
  resource_path = "${aws_api_gateway_resource.recordings.path}"
  role_arn      = "${aws_iam_role.lambda_role.arn}"

  environment_variables = {
    RECORDINGS_S3_BUCKET_ID = "${aws_s3_bucket.recordings.id}"
  }
}

resource "aws_iam_role" "lambda_role" {
  name               = "lambda-role"
  assume_role_policy = "${data.aws_iam_policy_document.lambda_role_policy_document.json}"
}

data "aws_iam_policy_document" "lambda_role_policy_document" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "archive_file" "lambda_zip_file" {
  type        = "zip"
  source_dir  = "../functions/build"
  output_path = "../functions/build.zip"
}
