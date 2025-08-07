variable "group_number" {
  description = "Your group number from Brightspace"
  type        = string
  validation {
    condition     = can(regex("^[0-9]+$", var.group_number))
    error_message = "Group number must be a number."
  }
}

variable "location" {
  description = "Azure region for all resources"
  type        = string
  default     = "East US"
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
