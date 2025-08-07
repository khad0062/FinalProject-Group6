
# Creates all resources needed for the Remix Weather Application

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

# Azure Container Registry
resource "azurerm_container_registry" "main" {
  name                = "${replace(var.project_name, "-", "")}acr"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true
}

# AKS Cluster for Test Environment
module "aks_test" {
  source = "../aks"

  project_name        = var.project_name
  environment         = "test"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = var.test_subnet_id
  kubernetes_version  = var.kubernetes_version
  vm_size            = var.vm_size
  node_count         = 1
  container_registry_id = azurerm_container_registry.main.id
  
  # Test environment specific networking
  dns_service_ip = "172.17.0.10"
  service_cidr   = "172.17.0.0/16"
}

# AKS Cluster for Production Environment
module "aks_prod" {
  source = "../aks"

  project_name        = var.project_name
  environment         = "prod"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = var.prod_subnet_id
  kubernetes_version  = var.kubernetes_version
  vm_size            = var.vm_size
  min_node_count     = 1
  max_node_count     = 3
  container_registry_id = azurerm_container_registry.main.id
  
  # Production environment specific networking
  dns_service_ip = "172.18.0.10"
  service_cidr   = "172.18.0.0/16"
}

# Azure Cache for Redis - Test Environment
resource "azurerm_redis_cache" "test" {
  name                = "${var.project_name}-test-redis"
  location            = var.location
  resource_group_name = var.resource_group_name
  capacity            = 0
  family              = "C"
  sku_name            = "Basic"
  
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"
  
  redis_configuration {
    enable_authentication = true
  }
}

# Azure Cache for Redis - Production Environment
resource "azurerm_redis_cache" "prod" {
  name                = "${var.project_name}-prod-redis"
  location            = var.location
  resource_group_name = var.resource_group_name
  capacity            = 0
  family              = "C"
  sku_name            = "Standard"
  
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"
  
  redis_configuration {
    enable_authentication = true
  }
}
