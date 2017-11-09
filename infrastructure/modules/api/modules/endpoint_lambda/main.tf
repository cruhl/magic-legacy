data "aws_caller_identity" "current" {}

resource "aws_lambda_function" "lambda" {
  function_name = "${var.project_prefix}-${var.name}"
  handler       = "index.${var.name}"
  role          = "${var.role_arn}"

  environment = {
    variables = "${var.environment_variables}"
  }

  filename         = "../functions/${var.name}/build.zip"
  source_code_hash = "${data.archive_file.source_zip_file.output_base64sha256}"

  runtime     = "nodejs6.10"
  memory_size = 512
}

data "archive_file" "source_zip_file" {
  type        = "zip"
  source_dir  = "../functions/${var.name}/build"
  output_path = "../functions/${var.name}/build.zip"
}

resource "aws_lambda_permission" "permission" {
  source_arn    = "arn:aws:execute-api:${var.region}:${data.aws_caller_identity.current.account_id}:${var.api_id}/*"
  function_name = "${aws_lambda_function.lambda.function_name}"
  statement_id  = "AllowExecutionFromApiGateway"
  action        = "lambda:InvokeFunction"
  principal     = "apigateway.amazonaws.com"
}

resource "aws_api_gateway_integration" "integration" {
  http_method = "${var.http_method}"

  uri  = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${aws_lambda_function.lambda.arn}/invocations"
  type = "AWS_PROXY"

  # http://docs.aws.amazon.com/apigateway/latest/developerguide/integrating-api-with-aws-services-lambda.html
  # This is where the invocation URL can be found ^

  rest_api_id             = "${var.api_id}"
  resource_id             = "${var.resource_id}"
  integration_http_method = "POST"
}
