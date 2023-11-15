resource "null_resource" "default" {
  provisioner "local-exec" {
    command = "echo ${var.test_value}"
  }
}

resource "linode_lke_cluster" "infrastructure" {
  label       = var.lke_label
  k8s_version = var.k8s_version
  region      = var.lke_region
  tags        = ["prod"]

  pool {
    type  = var.linode_instances_type
    count = 2

    autoscaler {
      min = 2
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
