variable "name" {
  type = "string"
}

variable "handler" {
  type = "string"
}

variable "http_method" {
  type = "string"
}

variable "environment_variables" {
  type = "map"
}

variable "source_hash" {
  type = "string"
}

variable "region" {
  type = "string"
}

variable "api_id" {
  type = "string"
}

variable "resource_id" {
  type = "string"
}

variable "resource_path" {
  type = "string"
}

variable "role_arn" {
  type = "string"
}
