
module "dns" {
  source         = "./modules/dns"
  token = var.token
}

module "lke" {
  source         = "./modules/lke"
  token = var.token
}
