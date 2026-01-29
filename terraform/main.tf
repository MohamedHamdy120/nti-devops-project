# Create multiple namespaces for our project
resource "kubernetes_namespace_v1" "project_namespaces" {
  for_each = toset(var.namespaces)
  
  metadata {
    name = each.value
    labels = {
      project     = var.project_name
      environment = var.environment
      managed-by  = "terraform"
    }
    annotations = {
      "description" = "Namespace for ${each.value} environment"
    }
  }
}

# Output the created namespaces
output "created_namespaces" {
  value       = { for ns in kubernetes_namespace_v1.project_namespaces : ns.metadata[0].name => ns.metadata[0].uid }
  description = "Map of created namespace names to their UIDs"
}
