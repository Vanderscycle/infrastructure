#
# https://terragrunt.gruntwork.io/docs/reference/built-in-functions/

locals {
  env_config     = yamldecode(file(find_in_parent_folders("environments.yml")))

  cloud_provider = split("/", path_relative_to_include())[1]
  env            = split("/", path_relative_to_include())[2]
  region         = split("/", path_relative_to_include())[3]

  account        = local.env_config[local.env].account_id

  path_to_tfstate = replace(path_relative_to_include(), "env/${local.cloud_provider}/", "")
  default_token   = ""
}

#
# Inject environment and region specific values as TF_VAR environment variables.
#
inputs = {
  env            = local.env
  region         = local.region
  cloud_provider = local.cloud_provider
  AWS_account_id = local.account
  LINODE_TOKEN   = get_env("LINODE_TOKEN", local.default_token)
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
    optional_var_files = [
      # path to tfvars specific to the environment-region-stack configuration
      "${get_terragrunt_dir()}/config.tfvars"
    ]
  }
}

generate "config" {
  path      = "config.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
  terraform {
    required_version = ">= 1.6.4"

      %{ if local.region == "us-west-2" }
      backend "s3" {
        bucket = "${local.env}-${local.region}-terraform-state"
        key   = "${local.path_to_tfstate}/terraform.tfstate"
        region = "${local.region}"
      }
      %{ endif }
    # cloud {
    #   hostname     = "app.terraform.io"
    #   organization = "vandersleyen"
    #   workspaces {
    #     name = "linode_infrastructure"
    #   }
    # }

    required_providers {
      %{ if local.region == "us-sea" }
      linode = {
        source  = "linode/linode"
        version = ">= 2.16.0"
      }
      %{ endif }
      %{ if local.region == "us-west-2" }
      aws = {
        source = "hashicorp/aws"
        version = ">= 5.44.0"
      }
      %{ endif }
    }
  }
  EOF
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "skip"
  contents  = <<EOF
%{ if local.region == "us-sea" }
  provider "linode" {
    token = var.LINODE_TOKEN
  }
%{ endif }
%{ if local.region == "us-west-2" }
  provider "aws" {
    region = var.region
  }
%{ endif }
EOF
}

generate "tfvars" {
  path              = "terragrunt.auto.tfvars.json"
  if_exists         = "overwrite"
  disable_signature = true
  contents          = jsonencode({ name = "your-name" })
}
