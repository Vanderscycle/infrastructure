variable "role_name" {
  default = "role_change_me"
  description = "Friendly name of the role. If omitted, Terraform will assign a random, unique name"
  type        = string
}

variable "tag_value" {
  default = "tag_change_me"
  description = "Key-value mapping of tags for the IAM role"
  type        = string
}
