terraform {
  required_version = ">= 1.0"
  
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.23.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.11.0"
    }
    kubectl = {
      source  = "alekc/kubectl"
      version = ">= 2.0.0"
    }
  }
  
  # We'll store state locally for now (later we can use remote)
  backend "local" {
    path = "./terraform.tfstate"
  }
}

# Provider configuration for Kubernetes
provider "kubernetes" {
  config_path = "~/.kube/config"  # Minikube kubeconfig
}

# Provider configuration for Helm
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

# Provider configuration for kubectl (for applying raw YAML)
provider "kubectl" {
  config_path = "~/.kube/config"
}
