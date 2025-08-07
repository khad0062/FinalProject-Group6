variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment (prod, test, dev)"
  type        = string
  validation {
    condition     = contains(["prod", "test", "dev"], var.environment)
    error_message = "Environment must be one of: prod, test, dev."
  }
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet where AKS will be deployed"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.32"
}

variable "vm_size" {
  description = "VM size for AKS nodes"
  type        = string
  default     = "Standard_B2s"
}

variable "node_count" {
  description = "Number of nodes (for non-prod environments)"
  type        = number
  default     = 1
}

variable "min_node_count" {
  description = "Minimum number of nodes (for prod environment with auto-scaling)"
  type        = number
  default     = 1
}

variable "max_node_count" {
  description = "Maximum number of nodes (for prod environment with auto-scaling)"
  type        = number
  default     = 3
}

variable "dns_service_ip" {
  description = "DNS service IP for AKS"
  type        = string
  default     = "172.16.0.10"
}

variable "service_cidr" {
  description = "Service CIDR for AKS"
  type        = string
  default     = "172.16.0.0/16"
}

variable "container_registry_id" {
  description = "ID of the Azure Container Registry (optional)"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
