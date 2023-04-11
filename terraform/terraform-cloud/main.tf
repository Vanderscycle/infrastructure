# resource "tfe_organization" "main-organization" {
#   name  = var.tfe_organization_name
#   email = var.tfe_organization_email
# }

resource "tfe_workspace" "main-workspace" {
  name         = var.tfe_workspace_name
  organization = var.tfe_organization_name
  tag_names    = ["gitops", "k8s"]
}
