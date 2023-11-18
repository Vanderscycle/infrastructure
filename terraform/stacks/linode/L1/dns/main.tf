resource "linode_domain" "domain" {
  for_each = toset(var.domain)

  domain    = each.value
  type    = "master"
  soa_email = var.soa_email
  tags = var.tags
}

# resource "linode_domain_record" "mx" {
#   for_each   = var.mx_record

#   domain_id  = linode_domain.domain[each.key].id
#   record_type = "MX"
#   name       = each.value.subdomain
#   target     = "${each.value.subdomain}.${var.domain}"
#   priority   = each.value.preference
# }
