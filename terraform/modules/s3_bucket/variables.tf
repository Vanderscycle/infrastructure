variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}
variable "acl" {
  description = "The canned ACL to apply to the S3 bucket"
  type        = string
}
variable "control_object_ownership" {
  description = "Whether to control object ownership"
  type        = bool
}
# Valid values: BucketOwnerEnforced, BucketOwnerPreferred or ObjectWriter
variable "object_ownership" {
  description = "The object ownership"
  type        = string
  default    = "BucketOwnerEnforced"
}
variable "versioning" {
  description = "Map containing versioning configuration."
  type        = map(string)
  default    = {
    enabled = false
  }
}
