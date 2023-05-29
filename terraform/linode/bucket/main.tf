data "linode_object_storage_cluster" "primary" {
  id = "us-east-1"
}

resource "linode_object_storage_bucket" "tf_state" {
  cluster = data.linode_object_storage_cluster.primary.id
  # cluster = "ca-central-1"
  label   = "infra-tf-state"
}
