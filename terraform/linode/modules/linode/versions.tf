terraform {

  required_version = ">= 1.0.1"

  required_providers {
    linode = {
      source  = "linode/linode"
      version = "1.30.0"
    }
  }
}