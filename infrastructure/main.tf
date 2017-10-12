provider "aws" {
  region = "${var.region}"
}

resource "aws_s3_bucket" "recordings" {
  bucket = "${var.project_prefix}-recordings"
}

resource "aws_api_gateway_rest_api" "api" {
  name = "${var.project_prefix}-api"
}

resource "aws_api_gateway_resource" "calls" {
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  parent_id   = "${aws_api_gateway_rest_api.api.root_resource_id}"
  path_part   = "calls"
}

resource "aws_api_gateway_method" "generate_twiml" {
  rest_api_id   = "${aws_api_gateway_rest_api.api.id}"
  resource_id   = "${aws_api_gateway_resource.calls.id}"
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "generate_twiml" {
  rest_api_id             = "${aws_api_gateway_rest_api.api.id}"
  resource_id             = "${aws_api_gateway_resource.calls.id}"
  http_method             = "${aws_api_gateway_method.generate_twiml.http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${aws_lambda_function.generate_twiml.arn}/invocations"
}

resource "aws_lambda_function" "generate_twiml" {
  function_name    = "generateTwiml"
  handler          = "index.generateTwiml"
  runtime          = "nodejs6.10"
  filename         = "../functions/build.zip"
  source_code_hash = "${data.archive_file.functions_zip_file.output_base64sha256}"
  role             = "${aws_iam_role.lambda_role.arn}"
}

resource "aws_iam_role" "lambda_role" {
  name               = "${var.project_prefix}-lambda-role"
  assume_role_policy = "${data.aws_iam_policy_document.lambda_role_policy.json}"
}

data "aws_iam_policy_document" "lambda_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"

      identifiers = [
        "lambda.amazonaws.com",
        "apigateway.amazonaws.com",
      ]
    }
  }
}

resource "aws_lambda_permission" "generate_twiml" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.generate_twiml.arn}"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.region}:${var.account_id}:${aws_api_gateway_rest_api.api.id}/*/${aws_api_gateway_method.generate_twiml.http_method}${aws_api_gateway_resource.calls.path}"
}

data "archive_file" "functions_zip_file" {
  type        = "zip"
  source_dir  = "../functions/build"
  output_path = "../functions/build.zip"
}
