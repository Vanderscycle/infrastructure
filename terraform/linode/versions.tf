terraform {

  required_version = ">= 1.0.1"
  cloud {
    organization = "{{ORGANIZATION_NAME}}"

    workspaces {
      name = "{{WORKSPACE_NAME}}"
    }
  }

  required_providers {
    linode = {
      source = "linode/linode"
      version = "1.30.0"
    }
  }
}
