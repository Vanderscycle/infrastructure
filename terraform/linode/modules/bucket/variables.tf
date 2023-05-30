# terraform apply -var="token=$LINODE_TOKEN"

variable "LINODE_TOKEN" {
  description = "The token used to authenticate with Terraform Cloud/Enterprise."
  type        = string
  # default     = ""
}
