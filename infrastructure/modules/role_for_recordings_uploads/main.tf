resource "aws_iam_role" "lambda_upload_role" {
  name               = "${var.project_prefix}-recordings-upload-role"
  assume_role_policy = "${module.lambda_trust_document.json}"
}

module "lambda_trust_document" {
  source = "../lambda_trust_document"
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  role       = "${aws_iam_role.lambda_upload_role.name}"
  policy_arn = "${aws_iam_policy.upload_policy.arn}"
}

resource "aws_iam_policy" "upload_policy" {
  name   = "${var.project_prefix}-recordings-upload-policy"
  policy = "${data.aws_iam_policy_document.policy_document.json}"
}

data "aws_iam_policy_document" "policy_document" {
  statement {
    effect    = "Allow"
    actions   = ["s3:PutObject"]
    resources = ["${var.bucket_arn}/*"]
  }
}
