# terraform apply -var="token=$LINODE_TOKEN"

variable "token" {
  description = "The token used to authenticate with Terraform Cloud/Enterprise."
  type = string
}
