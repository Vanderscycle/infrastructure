variable "image" {
  default = "linode/alpine3.18"
    type = string
  description = "An Image ID to deploy the Disk from. Official Linode Images start with linode/, while your Images start with private/"
}

variable "label" {
  default = ""
  type = string
  description = "The Linode's label is for display purposes only"
}

variable "group" {
  default = ""
  type = string
  description = "The display group of the Linode instance"
}


variable "region" {
  default = "ca-central"
  type = string
  description = "This is the location where the Linode is deployed"
}


variable "type" {
  default = "g6-nanode-1"
  type = string
  description = "The Linode type defines the pricing, CPU, disk, and RAM specs of the instance"
}
