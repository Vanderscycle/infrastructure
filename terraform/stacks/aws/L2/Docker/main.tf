locals {
  config_file = "gitops_secrets.yml"
  secret_file = "${path.module}/${local.config_file}"
  secret = yamldecode(file(local.secret_file))
}

resource "aws_ssm_parameter" "output" {
  for_each = {
    "token" = local.secret.docker.token
    "username" = local.secret.docker.username
  }

  name  = "/docker/creds/${each.key}"
  type  = "SecureString"
  value = each.value
}
