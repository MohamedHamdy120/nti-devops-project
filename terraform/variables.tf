variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
  default     = "minikube"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "nti-devops"
}

variable "namespaces" {
  description = "List of namespaces to create"
  type        = list(string)
  default     = ["dev", "staging", "prod", "monitoring", "cicd", "vault"]
}
