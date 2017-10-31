provider "aws" {
  region = "${var.region}"
}

module "recordings_bucket" {
  source = "./modules/recordings_bucket"
  project_prefix = "${var.project_prefix}"
  lambda_allow_assume_role_policy_document_json = "${module.lambda_allow_assume_role.lambda_allow_assume_role_policy_document_json}"
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
  source = "./modules/api_lambda"

  name        = "incoming-twilio-call"
  handler     = "index.incomingTwilioCall"
  http_method = "POST"

  environment_variables = {
    API_URL                 = "https://0dw5hfj6a1.execute-api.us-east-2.amazonaws.com/${var.stage}"
    API_SAVE_RECORDING_PATH = "${aws_api_gateway_resource.recordings.path}"
  }

  source_hash = "${data.archive_file.lambda_zip_file.output_base64sha256}"

  region        = "${var.region}"
  api_id        = "${aws_api_gateway_rest_api.api.id}"
  resource_id   = "${aws_api_gateway_resource.calls.id}"
  resource_path = "${aws_api_gateway_resource.calls.path}"
  role_arn      = "${module.lambda_allow_assume_role.arn}"
}

resource "aws_api_gateway_resource" "recordings" {
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  parent_id   = "${aws_api_gateway_rest_api.api.root_resource_id}"
  path_part   = "recordings"
}

module "save_twilio_call" {
  source = "./modules/api_lambda"

  name        = "save-twilio-call"
  handler     = "index.saveTwilioCall"
  http_method = "POST"

  source_hash = "${data.archive_file.lambda_zip_file.output_base64sha256}"

  region        = "${var.region}"
  api_id        = "${aws_api_gateway_rest_api.api.id}"
  resource_id   = "${aws_api_gateway_resource.recordings.id}"
  resource_path = "${aws_api_gateway_resource.recordings.path}"
  role_arn      = "${module.recordings_bucket.lambda_upload_role_arn}"

  environment_variables = {
    RECORDINGS_S3_BUCKET_ID = "${module.recordings_bucket.bucket_id}"
  }
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  role       = "${aws_iam_role.upload_role.name}"
  policy_arn = "${aws_iam_policy.upload_policy.arn}"
}

resource "aws_iam_role" "lambda_upload_role" {
  name               = "${var.project_prefix}-recordings-upload-role"
  assume_role_policy = "${var.lambda_allow_assume_role_document}"
}

resource "aws_iam_policy" "upload_policy" {
  name   = "${var.project_prefix}-recordings-upload-policy"
  policy = "${data.aws_iam_policy_document.policy_document.json}"
}

data "aws_iam_policy_document" "policy_document" {
  statement {
    effect    = "Allow"
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.bucket.arn}/*"]
  }
}

data "archive_file" "lambda_zip_file" {
  type        = "zip"
  source_dir  = "../functions/build"
  output_path = "../functions/build.zip"
}
