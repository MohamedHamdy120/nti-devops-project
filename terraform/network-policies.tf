# Default DENY ALL ingress traffic across all namespaces
resource "kubernetes_network_policy_v1" "default_deny_ingress" {
  for_each = toset(var.namespaces)
  
  metadata {
    name      = "default-deny-ingress"
    namespace = each.value
  }
  
  spec {
    pod_selector {}
    policy_types = ["Ingress"]
  }

  # Explicit dependency on namespace creation
  depends_on = [kubernetes_namespace_v1.project_namespaces]
}

# Allow traffic within the same namespace (pod-to-pod)
resource "kubernetes_network_policy_v1" "allow_same_namespace" {
  for_each = toset(var.namespaces)
  
  metadata {
    name      = "allow-same-namespace"
    namespace = each.value
  }
  
  spec {
    pod_selector {}
    policy_types = ["Ingress"]
    
    ingress {
      from {
        pod_selector {}
      }
    }
  }

  # Explicit dependency on namespace creation
  depends_on = [kubernetes_namespace_v1.project_namespaces]
}
