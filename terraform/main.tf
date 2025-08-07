# Main Terraform Configuration
# This is the root configuration that uses all the modules

terraform {
  required_version = ">= 1.5"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }

  # Backend configuration - uncomment and configure after creating the backend storage
  # backend "azurerm" {
  #   resource_group_name  = "cst8918-final-project-backend-rg"
  #   storage_account_name = "cst8918backendstorageXXX"  # Replace XXX with unique suffix
  #   container_name       = "tfstate"
  #   key                  = "terraform.tfstate"
  # }
}

provider "azurerm" {
  features {}
}

# Local values for consistent naming
locals {
  project_name    = "cst8918-final-project-group-${var.group_number}"
  common_tags = {
    Project     = "CST8918 Final Project"
    Group       = "Group ${var.group_number}"
    Environment = "Multi"
    ManagedBy   = "Terraform"
  }
}

# Network Infrastructure Module
module "network" {
  source = "./modules/network"

  resource_group_name = "${local.project_name}-rg"
  project_name        = local.project_name
  location            = var.location
  tags                = local.common_tags
}

# Weather Application Module
module "weather_app" {
  source = "./modules/weather-app"

  project_name        = local.project_name
  resource_group_name = module.network.resource_group_name
  location            = module.network.location
  test_subnet_id      = module.network.test_subnet_id
  prod_subnet_id      = module.network.prod_subnet_id
  kubernetes_version  = var.kubernetes_version
  vm_size            = var.vm_size
  
  tags = local.common_tags

  depends_on = [module.network]
}
