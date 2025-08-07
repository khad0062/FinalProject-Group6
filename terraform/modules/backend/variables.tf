variable "resource_group_name" {
  description = "Name of the resource group for the backend storage"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the storage account for Terraform backend"
  type        = string
  validation {
    condition     = length(var.storage_account_name) >= 3 && length(var.storage_account_name) <= 24 && can(regex("^[a-z0-9]+$", var.storage_account_name))
    error_message = "Storage account name must be between 3 and 24 characters long and contain only lowercase letters and numbers."
  }
}

variable "container_name" {
  description = "Name of the storage container for Terraform state"
  type        = string
  default     = "tfstate"
}

variable "location" {
  description = "Azure region for the backend resources"
  type        = string
  default     = "East US"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
