variable "region" {}
variable "env" {}
variable "cloud_provider" {}
variable "LINODE_TOKEN" {}

variable "domain" {
  description = "The domain name to manage"
  type        = list(string)
  default     = []
}

variable "soa_email" {
  description = "The email address for the SOA record"
  type        = string
  default     = "henri-vandersleyen@protonmail.com"
}

variable "mx_record" {
  description = "The MX record for the domain"
  type        = map(object({
    preference = number
    subdomain  = string
  }))
  default = {
    mail = {
      preference = 10
      subdomain  = "mail"
    }
  }
}
variable "tags" {
  description = "Tags to apply to all Linode resources."
  type        = list(string)
  default     = ["terraform"]
}
