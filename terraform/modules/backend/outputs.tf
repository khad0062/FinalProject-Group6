output "resource_group_name" {
  description = "Name of the created resource group"
  value       = azurerm_resource_group.backend.name
}

output "storage_account_name" {
  description = "Name of the created storage account"
  value       = azurerm_storage_account.backend.name
}

output "storage_account_primary_key" {
  description = "Primary access key for the storage account"
  value       = azurerm_storage_account.backend.primary_access_key
  sensitive   = true
}

output "container_name" {
  description = "Name of the storage container"
  value       = azurerm_storage_container.backend.name
}

output "backend_config" {
  description = "Backend configuration for use in other Terraform configurations"
  value = {
    resource_group_name  = azurerm_resource_group.backend.name
    storage_account_name = azurerm_storage_account.backend.name
    container_name       = azurerm_storage_container.backend.name
    key                  = "terraform.tfstate"
  }
}
