variable "aws_region" {
  description = "AWS region for all resources."
  type        = string
  default     = "eu-west-1"
}

variable "access_key" {
  description = "IAM user access key id"
  type        = string
}

variable "secret_key" {
  description = "IAM user access key secret"
  type        = string
}
