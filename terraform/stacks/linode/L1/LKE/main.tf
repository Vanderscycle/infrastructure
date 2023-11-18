locals {
  name = "${var.env}-${var.region}-${var.cloud_provider}"
}

resource "linode_lke_cluster" "infrastructure" {
  label       = local.name
  k8s_version = var.k8s_version
  region      = var.lke_region
  tags        = var.tags

  pool {
    type  = var.linode_instances_type
    count = var.autoscaler_min

    autoscaler {
      min = var.autoscaler_min
      max = var.autoscaler_max
    }
  }

  # Prevent the count field from overriding autoscaler-created nodes
  lifecycle {
    ignore_changes = [
      pool.0.count
    ]
  }
}
