variable "region" {}
variable "env" {}
variable "cloud_provider" {}
variable "LINODE_TOKEN" {}

variable "autoscaler_min" {
  description = "Minimum number of nodes in the Node Pool."
  default     = 2
  type        = number
}
variable "autoscaler_max" {
  description = "Maximum number of nodes in the Node Pool."
  default     = 10
  type        = number
}

variable "lke_label" {
  description = "Unique cluster's label"
  default     = "infrastructure"
  type        = string
}
variable "k8s_version" {
  description = "The desired Kubernetes version for this Kubernetes cluster."
  default     = "1.27"
  type        = string
}
variable "lke_region" {
  description = "This Kubernetes cluster's location"
  default     = "ca-central"
  type        = string
}

variable "linode_instances_type" {
  description = "Linode Type for all of the nodes in the Node Pool."
  default     = "g6-standard-2"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all Linode resources."
  type        = list(string)
  default     = ["terraform"]
}
