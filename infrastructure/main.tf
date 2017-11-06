provider "aws" {
  region = "${var.aws_region}"
}

provider "google" {
  region = "${var.aws_region}"
}

module "google_apis" {
  source     = "./modules/google_apis"
  project_id = "${var.google_project_id}"
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
    "module.create_call_lambda",
    "module.create_recording_lambda",
  ]
}

module "api_gateway" {
  source = "./modules/api_gateway"
}

module "create_call_lambda" {
  source = "./modules/api_gateway_invoked_lambda"

  api_id      = "${module.api_gateway.id}"
  resource_id = "${module.api_gateway.calls_resource_id}"
  http_method = "${module.api_gateway.calls_http_method}"

  name        = "create-call"
  handler     = "index.createCall"
  source_hash = "${data.archive_file.lambda_zip_file.output_base64sha256}"

  environment_variables = {
    API_URL                 = "https://ozhzxmq19c.execute-api.us-east-2.amazonaws.com/${var.api_stage}"
    API_SAVE_RECORDING_PATH = "${module.api_gateway.recordings_path}"
  }

  region   = "${var.aws_region}"
  role_arn = "${aws_iam_role.lambda_allow_assume_role.arn}"
}

resource "aws_iam_role" "lambda_allow_assume_role" {
  name               = "${var.project_prefix}-lambda-allow-assume-role"
  assume_role_policy = "${module.lambda_trust_document.json}"
}

module "lambda_trust_document" {
  source = "./modules/lambda_trust_document"
}

module "create_recording_lambda" {
  source = "./modules/api_gateway_invoked_lambda"

  api_id      = "${module.api_gateway.id}"
  resource_id = "${module.api_gateway.recordings_resource_id}"
  http_method = "POST"

  name        = "create-recording"
  handler     = "index.createRecording"
  source_hash = "${data.archive_file.lambda_zip_file.output_base64sha256}"

  environment_variables = {
    RECORDINGS_S3_BUCKET_ID = "${module.recordings_s3_bucket.id}"
  }

  region   = "${var.aws_region}"
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
