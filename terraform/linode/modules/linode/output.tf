resource "linode_instance" "terraform-web" {
  image     = var.image
  label     = var.label
  group     = var.group
  region    = var.region
  type      = var.type
  root_pass = "YOUR_ROOT_PASSWORD"
}
