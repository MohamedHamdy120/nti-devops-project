# Ingress resource for our Hello World app
resource "kubernetes_ingress_v1" "hello_world" {
  metadata {
    name      = "hello-world-ingress"
    namespace = "dev"
    
    annotations = {
      "nginx.ingress.kubernetes.io/rewrite-target" = "/"
      "nginx.ingress.kubernetes.io/ssl-redirect"   = "false"
    }
  }
  
  spec {
    ingress_class_name = "nginx"  # Use the default class
    
    rule {
      http {
        path {
          path = "/"
          path_type = "Prefix"
          
          backend {
            service {
              name = "hello-world-service"
              port {
                number = 8080
              }
            }
          }
        }
        
        path {
          path = "/health"
          path_type = "Exact"
          
          backend {
            service {
              name = "hello-world-service"
              port {
                number = 8080
              }
            }
          }
        }
      }
    }
  }
  
  depends_on = [helm_release.nginx_ingress]
}

# Ingress for monitoring dashboard
resource "kubernetes_ingress_v1" "monitoring" {
  metadata {
    name      = "monitoring-ingress"
    namespace = "monitoring"
    
    annotations = {
      "nginx.ingress.kubernetes.io/rewrite-target" = "/"
    }
  }
  
  spec {
    ingress_class_name = "nginx"
    
    rule {
      http {
        path {
          path = "/grafana"
          path_type = "Prefix"
          
          backend {
            service {
              name = "grafana"
              port {
                number = 3000
              }
            }
          }
        }
        
        path {
          path = "/prometheus"
          path_type = "Prefix"
          
          backend {
            service {
              name = "prometheus-server"
              port {
                number = 9090
              }
            }
          }
        }
      }
    }
  }
  
  depends_on = [helm_release.nginx_ingress]
}
