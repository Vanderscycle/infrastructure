variable "tfe_organization_name" {
  description = "Name of the organization"
  default = "vandersleyen"
  type = string
}

variable "tfe_organization_email" {
  description = "Email associated with the organization"
  default = "henri-vandersleyen@protonmail.com"
  type = string
}

variable "tfe_workspace_name" {
  description = "Name of the workspace"
  default = "K8s"
  type = string
}

variable "provider_token" {
  type = string
  sensitive = true
}
