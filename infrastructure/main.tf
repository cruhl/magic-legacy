provider "aws" {
  region = "${var.region}"
}

module "recordings_s3_bucket" {
  source         = "./modules/recordings_s3_bucket"
  project_prefix = "${var.project_prefix}"
}

resource "aws_api_gateway_deployment" "api_deployment" {
  stage_name  = "${var.api_stage}"
  rest_api_id = "${module.api_gateway.id}"

  depends_on = [
    "module.api_gateway",
    "module.incoming_twilio_call",
    "module.save_twilio_call",
  ]
}

module "api_gateway" {
  source = "./modules/api_gateway"
}

module "incoming_twilio_call" {
  source = "./modules/api_gateway_invoked_lambda"

  api_id      = "${module.api_gateway.id}"
  resource_id = "${module.api_gateway.calls_resource_id}"
  http_method = "${module.api_gateway.calls_http_method}"

  name        = "incoming-twilio-call"
  handler     = "index.incomingTwilioCall"
  source_hash = "${data.archive_file.lambda_zip_file.output_base64sha256}"

  environment_variables = {
    API_URL                 = "https://ozhzxmq19c.execute-api.us-east-2.amazonaws.com/${var.api_stage}"
    API_SAVE_RECORDING_PATH = "${module.api_gateway.recordings_path}"
  }

  region   = "${var.region}"
  role_arn = "${aws_iam_role.lambda_allow_assume_role.arn}"
}

resource "aws_iam_role" "lambda_allow_assume_role" {
  name               = "${var.project_prefix}-lambda-allow-assume-role"
  assume_role_policy = "${module.lambda_trust_document.json}"
}

module "lambda_trust_document" {
  source = "./modules/lambda_trust_document"
}

module "save_twilio_call" {
  source = "./modules/api_gateway_invoked_lambda"

  api_id      = "${module.api_gateway.id}"
  resource_id = "${module.api_gateway.recordings_resource_id}"
  http_method = "POST"

  name        = "save-twilio-call"
  handler     = "index.saveTwilioCall"
  source_hash = "${data.archive_file.lambda_zip_file.output_base64sha256}"

  environment_variables = {
    RECORDINGS_S3_BUCKET_ID = "${module.recordings_s3_bucket.id}"
  }

  region   = "${var.region}"
  role_arn = "${module.role_for_recordings_uploads.arn}"
}

module "role_for_recordings_uploads" {
  source = "./modules/role_for_recordings_uploads"

  project_prefix = "${var.project_prefix}"
  bucket_arn     = "${module.recordings_s3_bucket.arn}"
}

data "archive_file" "lambda_zip_file" {
  type        = "zip"
  source_dir  = "../functions/build"
  output_path = "../functions/build.zip"
}
