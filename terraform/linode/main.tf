
module "dns" {
  source         = "./modules/dns"
  token = var.LINODE_TOKEN
}

module "lke" {
  source         = "./modules/lke"
  token = var.LINODE_TOKEN
}
