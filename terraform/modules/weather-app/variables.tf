variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "test_subnet_id" {
  description = "ID of the test subnet"
  type        = string
}

variable "prod_subnet_id" {
  description = "ID of the production subnet"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version for AKS clusters"
  type        = string
  default     = "1.32"
}

variable "vm_size" {
  description = "VM size for AKS nodes"
  type        = string
  default     = "Standard_B2s"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
