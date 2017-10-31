resource "aws_iam_role" "role" {
  name               = "lambda-allow-assume-role"
  assume_role_policy = "${data.aws_iam_policy_document.policy_document.json}"
}

data "aws_iam_policy_document" "policy_document" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}