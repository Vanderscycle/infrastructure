resource "linode_vpc" "kubernetes_compute" {
  label       = "kubernetes-compute-${var.env}"
  region      = var.region
  description = "kubernetes computes containing"
}


resource "linode_vpc_subnet" "test" {
  for_each = var.subnets
  vpc_id = linode_vpc.kubernetes_compute.id
  label  =  each.key
  ipv4   = each.value.ipv4
}
