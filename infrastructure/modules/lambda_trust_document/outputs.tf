output "json" {
  value = "${data.aws_iam_policy_document.policy_document.json}"
}
