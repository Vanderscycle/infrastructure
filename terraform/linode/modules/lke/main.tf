module "linode_lke_cluster" "infrastructure" {
  label       = var.lke_region
  k8s_version = var.k8s_version
  region      = var.lke_region
  tags        = ["prod"]

  pool {
    type  = var.linode_instances_type
    count = 3

    autoscaler {
      min = 3
      max = 10
    }
  }

  # Prevent the count field from overriding autoscaler-created nodes
  lifecycle {
    ignore_changes = [
      pool.0.count
    ]
  }
}
