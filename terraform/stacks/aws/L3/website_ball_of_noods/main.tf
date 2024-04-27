resource "aws_ssm_parameter" "output" {
  for_each = {
    "backend_api_url" = "cafecrochetbackend.vandersleyen.dev"
    "current_state" = var.env
  }

  name  = "/website/ballofnoods/frontend/${each.key}"
  type  = "SecureString"
  value = each.value
}
