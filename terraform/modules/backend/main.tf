# Terraform Backend Module - Azure Blob Storage
# This module creates the Azure Storage Account and Container for Terraform state

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

resource "azurerm_resource_group" "backend" {
  name     = var.resource_group_name
  location = var.location
  
  tags = var.tags
}

resource "azurerm_storage_account" "backend" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.backend.name
  location                = azurerm_resource_group.backend.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  
  # Security configurations
  public_network_access_enabled   = true
  allow_nested_items_to_be_public = false
  
  blob_properties {
    versioning_enabled = true
    delete_retention_policy {
      days = 7
    }
    container_delete_retention_policy {
      days = 7
    }
  }
  
  tags = var.tags
}

resource "azurerm_storage_container" "backend" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.backend.name
  container_access_type = "private"
}

# Create a storage account key for accessing the backend
data "azurerm_storage_account" "backend" {
  name                = azurerm_storage_account.backend.name
  resource_group_name = azurerm_resource_group.backend.resource_group_name
}
