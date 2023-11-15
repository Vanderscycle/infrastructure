#
# https://terragrunt.gruntwork.io/docs/reference/built-in-functions/

locals {

  cloud_provider  = split("/", path_relative_to_include())[1]
  region  = split("/", path_relative_to_include())[2]
  env     = split("/", path_relative_to_include())[3]


  path_to_common  = replace(get_terragrunt_dir(), "env/${local.cloud_provider}/", "env/common")
  path_to_tfstate = replace(path_relative_to_include(), "env/${local.cloud_provider}/", "")
}

#
# Inject environment and region specific values as TF_VAR environment variables.
#
inputs = {
  env         = local.env
  region      = local.region
  cloud_provider      = local.cloud_provider
}


#
# Consume a config.tfvars var file located in the same directory as the child terragrunt.hcl file.
#
terraform {
  extra_arguments "init_args" {
    commands = [
      "init"
    ]

    # arguments = [
    #   "-reconfigure",
    # ]
  }

  extra_arguments "custom_vars" {
    commands = get_terraform_commands_that_need_vars()

    # precedence:
    #    1. {cloud_provider}/{ region }/{env}/Ln/{ stack }/config.tfvars
    #    2. common/{ region }/Ln/{ stack }/config.tfvars
    optional_var_files = [
      # path to common tfvars for the selected module
      "${local.path_to_common}/config.tfvars",

      # path to tfvars specific to the environment-region-stack configuration
      "${get_terragrunt_dir()}/config.tfvars"
    ]
  }
}

generate "config" {
  path      = "config.tf"
  if_exists = "skip"
  contents  = <<EOF
    terraform {

      required_version = ">= 1.3.0"

      # cloud {
      #   hostname     = "app.terraform.io"
      #   organization = "vandersleyen"
      #   workspaces {
      #     name = "linode_infrastructure"
      #   }
      # }

      required_providers {
        linode = {
          source  = "linode/linode"
          version = "1.30.0"
        }
      }
    }
  EOF
}
generate "provider" {
  path = "provider.tf"
  if_exists = "skip"
  contents  = <<EOF
  provider "linode" {
    token = var.LINODE_TOKEN
  }
  EOF
}
generate "tfvars" {
  path      = "terragrunt.auto.tfvars.json"
  if_exists = "overwrite"
  disable_signature = true
  contents = jsonencode({name = "your-name"})
}
