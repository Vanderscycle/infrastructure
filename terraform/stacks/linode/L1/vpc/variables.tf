variable "region" {}
variable "env" {}
variable "cloud_provider" {}
variable "LINODE_TOKEN" {}

variable "subnets" {
  type = map(object({
    ipv4 = string
  }))
}
