
output "kubeconfig" {
  value       = linode_lke_cluster.infrastructure.kubeconfig
  description = "The base64 encoded kubeconfig for the Kubernetes cluster."
}

output "dashboard_url" {
  value       = linode_lke_cluster.infrastructure.dashboard_url
  description = "The Kubernetes Dashboard access URL for this cluster."
}
