provider "aws" {
  region = "${var.aws_region}"
}

provider "google" {
  region = "${var.google_region}"
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
  rest_api_id = "${module.api.api_gateway_id}"
  depends_on  = ["module.api"]
}

module "api" {
  source = "./modules/api"

  project_prefix = "${var.project_prefix}"

  region    = "${var.aws_region}"
  api_stage = "${var.api_stage}"

  recordings_s3_bucket_id  = "${module.recordings_s3_bucket.id}"
  recordings_s3_bucket_arn = "${module.recordings_s3_bucket.arn}"
}

module "create_memo_lambda" {
  source = "./modules/create_memo_lambda"

  recordings_s3_bucket_id  = "${module.recordings_s3_bucket.id}"
  recordings_s3_bucket_arn = "${module.recordings_s3_bucket.arn}"
}
