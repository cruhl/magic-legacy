output "arn" {
	value = "${aws_iam_role.role.arn}"
}

output "policy_document_json" {
	value="${data.aws_iam_policy_document.policy_document.json}"
}