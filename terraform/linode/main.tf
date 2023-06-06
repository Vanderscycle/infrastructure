module "dns" {
  source = "../modules/linode/dns"
}

module "lke" {
  source = "../modules/linode/lke"
}

# module "bucket" {
#   source         = "./modules/bucket"
# }

# module "linode_instance" {
#   source         = "./modules/linode_instance"
# }
