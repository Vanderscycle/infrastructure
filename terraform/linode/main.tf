module "dns" {
  source         = "./modules/dns"
}

module "lke" {
  source         = "./modules/lke"
}

# module "bucket" {
#   source         = "./modules/bucket"
# }

# module "linode_instance" {
#   source         = "./modules/linode_instance"
# }
