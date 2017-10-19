variable "access_key_id" {}
variable "aws_secret_access_key" {}

variable "region" {
  default = "us-east-2"
}

variable "project_prefix" {
  default = "cruhl-magic"
}

variable "stage" {
  default = "prod"
}
