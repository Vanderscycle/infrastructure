data "aws_ssoadmin_instances" "this" {}

resource "aws_identitystore_group" "this" {
  display_name      = "DevOps"
  description       = "DevOps group"
  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
}
