terraform {

  required_version = ">= 1.0.1"

  cloud {
    organization = "vandersleyen"
    workspaces {
      name = "K8s"
    }
  }

  required_providers {
    linode = {
      source = "linode/linode"
      version = "1.30.0"
    }
  }
}
