variable "region" {}
variable "env" {}
variable "AWS_account_id" {}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default    = "CHANGE_ME"
}
variable "acl" {
  description = "The canned ACL to apply to the S3 bucket"
  type        = string
  default = "private"
}
variable "versioning" {
  description = "Map containing versioning configuration."
  type        = map(string)
  default    = {
    enabled = true
  }
}
