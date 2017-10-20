variable "name" {}
variable "handler" {}
variable "http_method" {}

variable "environment_variables" {
  type = "map"
}

variable "source_hash" {}

variable "region" {}
variable "api_id" {}
variable "resource_id" {}
variable "resource_path" {}
variable "role_arn" {}

data "aws_caller_identity" "current" {}

resource "aws_api_gateway_method" "method" {
  rest_api_id   = "${var.api_id}"
  resource_id   = "${var.resource_id}"
  http_method   = "${var.http_method}"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = "${var.api_id}"
  resource_id             = "${var.resource_id}"
  http_method             = "${aws_api_gateway_method.method.http_method}"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${aws_lambda_function.lambda_function.arn}/invocations"
  type                    = "AWS_PROXY"
  integration_http_method = "POST"
}

resource "aws_lambda_permission" "permission" {
  source_arn    = "arn:aws:execute-api:${var.region}:${data.aws_caller_identity.current.account_id}:${var.api_id}/*/${aws_api_gateway_method.method.http_method}${var.resource_path}"
  function_name = "${aws_lambda_function.lambda_function.function_name}"
  statement_id  = "AllowExecutionFromApiGateway"
  action        = "lambda:InvokeFunction"
  principal     = "apigateway.amazonaws.com"
}

resource "aws_lambda_function" "lambda_function" {
  function_name = "${var.name}"
  handler       = "${var.handler}"

  filename         = "../functions/build.zip"
  source_code_hash = "${var.source_hash}"

  runtime     = "nodejs6.10"
  memory_size = 512

  role = "${var.role_arn}"

  environment = {
    variables = "${var.environment_variables}"
  }
}
