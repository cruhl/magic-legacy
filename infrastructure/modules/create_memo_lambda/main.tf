# resource "aws_lambda_function" "lambda" {
#   function_name = "create-memo"
#   handler       = "index.createMemo"

#   filename         = "../functions/build.zip"
#   source_code_hash = "${var.source_hash}"

#   runtime     = "nodejs6.10"
#   memory_size = 512

#   role = "${var.role_arn}"

#   environment = {
#     variables = {
#       RECORDINGS_BUCKET = "${var.recordings_s3_bucket_id}"
#     }
#   }
# }
