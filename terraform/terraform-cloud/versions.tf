terraform {

  required_version = ">= 1.0.1"

  cloud {
    organization = "vandersleyen"
    workspaces {
      name = "K8s"
    }
  }
  required_providers {
    tfe = {
      source = "hashicorp/tfe"
      version = "0.43.0"
    }
  }
}

