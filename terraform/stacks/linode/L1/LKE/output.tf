# output "cloud_provider" {
#   value = var.cloud_provider
# }
output "region" {
  value = var.region
}
output "env" {
  value = var.env
}


output "test" {
  value       = var.test_value
}
output "cloud_provider" {
  value = var.cloud_provider
}

output "kubeconfig" {
  value       = linode_lke_cluster.infrastructure.kubeconfig
  description = "The base64 encoded kubeconfig for the Kubernetes cluster."
  sensitive = true
}

output "dashboard_url" {
  value       = linode_lke_cluster.infrastructure.dashboard_url
  description = "The Kubernetes Dashboard access URL for this cluster."
}
