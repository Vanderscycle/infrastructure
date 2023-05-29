terraform {

  required_version = ">= 1.0.1"

  cloud {
    organization = "vandersleyen"
    workspaces {
      name = "linode_infrastructure"
    }
  }

  required_providers {
    linode = {
      source  = "linode/linode"
      version = "1.30.0"
    }
  }
}
