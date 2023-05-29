terraform {

  required_version = ">= 1.0.1"

  # cloud {
  #   organization = "vandersleyen"
  #   workspaces {
  #     name = "K8s"
  #   }
  # }

  required_providers {
    linode = {
      source = "linode/linode"
      version = "1.30.0"
    }
  }
  # only works with s3
  # backend "s3" {
  #   endpoint                    = "ca-central.linodeobjects.com"
  #   profile                     = "linode-s3"
  #   skip_credentials_validation = true
  #   bucket                      = "infra-tf-state"
  #   key                         = "infrastructure/buckets/terraform.tfstate"
  #   region                      = "ca-central-1"
  # }
  }
