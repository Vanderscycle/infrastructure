# resource "linode_instance" "terraform-web" {
#   image     = "linode/ubuntu18.04"
#   label     = "Terraform-Web-Example"
#   group     = "Terraform"
#   region    = "us-east"
#   type      = "g6-standard-1"
#   root_pass = "YOUR_ROOT_PASSWORD"
# }
module "dns" {
  source         = "./modules/dns"
}

module "lke" {
  source         = "./modules/lke"
}

module "bucket" {
  source         = "./modules/bucket"
}
