output "cluster_info" {
  value = {
    name      = var.cluster_name
    provider  = "minikube"
    environment = var.environment
  }
  description = "Information about the Kubernetes cluster"
}

output "namespaces_created" {
  value = [for ns in var.namespaces : ns]
  description = "List of namespaces created by Terraform"
}
