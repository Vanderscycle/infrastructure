# update to https://github.com/terraform-aws-modules/terraform-aws-kms
resource "aws_kms_key" "tf_secrets_file" {
  multi_region             = false
  enable_key_rotation      = true
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  description              = "kms key for ${var.region}/${var.env}"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_kms_alias" "tf_secrets_file_alias" {
  name          = "alias/terraform/secrets"
  target_key_id = aws_kms_key.tf_secrets_file.key_id

  lifecycle {
    prevent_destroy = true
  }
}
