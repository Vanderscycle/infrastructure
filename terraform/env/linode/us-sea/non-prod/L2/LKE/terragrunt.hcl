include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_path_to_repo_root()}terraform//stacks/linode/L2/LKE"
}
