data "aws_caller_identity" "current" {}

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

resource "aws_lambda_permission" "permission" {
  source_arn    = "arn:aws:execute-api:${var.region}:${data.aws_caller_identity.current.account_id}:${var.api_id}/*"
  function_name = "${aws_lambda_function.lambda_function.function_name}"
  statement_id  = "AllowExecutionFromApiGateway"
  action        = "lambda:InvokeFunction"
  principal     = "apigateway.amazonaws.com"
}

resource "aws_api_gateway_method" "method" {
  rest_api_id   = "${var.api_id}"
  resource_id   = "${var.resource_id}"
  http_method   = "${var.http_method}"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration" {
  http_method = "${aws_api_gateway_method.method.http_method}"

  uri  = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${aws_lambda_function.lambda_function.arn}/invocations"
  type = "AWS_PROXY"

  # http://docs.aws.amazon.com/apigateway/latest/developerguide/integrating-api-with-aws-services-lambda.html
  # This is where the invocation URL can be found ^

  rest_api_id             = "${var.api_id}"
  resource_id             = "${var.resource_id}"
  integration_http_method = "POST"
}
