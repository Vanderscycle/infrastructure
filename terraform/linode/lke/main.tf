resource "linode_domain" "printer_exchange" {
    type = "master"
    domain = "3dprinterexchange.dev"
    soa_email = "henri-vandersleyen@protonmail.com"
}

resource "linode_domain_record" "printer_exchange" {
    domain_id = linode_domain.printer_exchange.id
    name = "www"
    record_type = "CNAME"
    target = "3dprinterexchange.dev"
    ttl_sec = 300
}
