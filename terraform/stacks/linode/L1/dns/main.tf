resource "linode_domain" "domain" {
  for_each = toset(var.domain)

  domain    = each.value
  type    = "master"
  soa_email = var.soa_email
  tags = var.tags
}

# resource "linode_domain_record" "foobar" {
#     domain_id = linode_domain.domain.id
#     name = "nextcloud"
#     record_type = "AAAA"
#     target = "vandersleyen.dev"
# }
