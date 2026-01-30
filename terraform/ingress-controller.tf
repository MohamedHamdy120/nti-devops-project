# Install Nginx Ingress Controller using Helm - WITHOUT ADMISSION WEBHOOK
resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress-controller"
  namespace  = "ingress-nginx"
  
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.7.1"
  
  # Create the namespace
  create_namespace = true
  
  # Disable IngressClass resource creation
  set {
    name  = "controller.ingressClassResource.enabled"
    value = "false"
  }
  
  # Use the default IngressClass
  set {
    name  = "controller.ingressClass"
    value = "nginx"
  }
  
  set {
    name  = "controller.service.type"
    value = "NodePort"
  }
  
  set {
    name  = "controller.service.nodePorts.http"
    value = "30080"
  }
  
  set {
    name  = "controller.service.nodePorts.https"
    value = "30443"
  }
  
  set {
    name  = "controller.metrics.enabled"
    value = "true"
  }
  
  # CRITICAL: DISABLE admission webhooks for local environment
  set {
    name  = "controller.admissionWebhooks.enabled"
    value = "false"
  }
  
  set {
    name  = "controller.admissionWebhooks.patch.enabled"
    value = "false"
  }
  
  # Add resource limits
  set {
    name  = "controller.resources.requests.cpu"
    value = "100m"
  }
  
  set {
    name  = "controller.resources.requests.memory"
    value = "128Mi"
  }
  
  set {
    name  = "controller.resources.limits.cpu"
    value = "500m"
  }
  
  set {
    name  = "controller.resources.limits.memory"
    value = "512Mi"
  }
  
  # Wait for installation
  wait = true
  timeout = 600
}

output "ingress_controller_status" {
  value = helm_release.nginx_ingress.status
}
