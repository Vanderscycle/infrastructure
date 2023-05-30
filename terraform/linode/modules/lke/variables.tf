# terraform apply -var="token=$LINODE_TOKEN"


variable "lke_label" {
  description = "Unique cluster's label"
  default     = "infrastructure"
  type        = string
}
variable "k8s_version" {
  description = "The desired Kubernetes version for this Kubernetes cluster."
  default     = "1.26"
  type        = string
}
variable "lke_region" {
  description = "This Kubernetes cluster's location"
  default     = "ca-central"
  type        = string
}

variable "linode_instances_type" {
  description = "Linode Type for all of the nodes in the Node Pool."
  default     = "g6-standard-1"
  type        = string
}

variable "LINODE_TOKEN" {
  description = "The token used to authenticate with Terraform Cloud/Enterprise."
  type        = string
  # default     = ""
}
