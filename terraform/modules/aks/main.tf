
# Creates AKS clusters for different environments

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

# AKS Cluster
resource "azurerm_kubernetes_cluster" "main" {
  name                = "${var.project_name}-${var.environment}-aks"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "${var.project_name}-${var.environment}-aks"
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name           = "default"
    vm_size        = var.vm_size
    vnet_subnet_id = var.subnet_id
    
    # Environment-specific node configuration
    node_count          = var.environment == "prod" ? null : var.node_count
    enable_auto_scaling = var.environment == "prod" ? true : false
    min_count          = var.environment == "prod" ? var.min_node_count : null
    max_count          = var.environment == "prod" ? var.max_node_count : null
    
    # Security and performance settings
    os_disk_size_gb = 30
    os_disk_type    = "Managed"
    
    upgrade_settings {
      max_surge = "10%"
    }
  }

  # Identity configuration
  identity {
    type = "SystemAssigned"
  }

  # Network configuration
  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"
    dns_service_ip    = var.dns_service_ip
    service_cidr      = var.service_cidr
    load_balancer_sku = "standard"
  }

  # Security and monitoring
  azure_policy_enabled             = true
  http_application_routing_enabled  = false
  oidc_issuer_enabled              = true
  workload_identity_enabled        = true

  # Key Vault secrets provider
  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  # Maintenance window
  maintenance_window_auto_upgrade {
    frequency   = "Weekly"
    interval    = 1
    duration    = 4
    day_of_week = "Sunday"
    start_time  = "02:00"
    utc_offset  = "+00:00"
  }

  maintenance_window_node_os {
    frequency   = "Weekly"
    interval    = 1
    duration    = 4
    day_of_week = "Sunday"
    start_time  = "02:00"
    utc_offset  = "+00:00"
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [
      default_node_pool[0].node_count
    ]
  }
}

# Role assignment for AKS to pull images from ACR
resource "azurerm_role_assignment" "aks_acr" {
  count                = var.container_registry_id != null ? 1 : 0
  principal_id         = azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id
  role_definition_name = "AcrPull"
  scope                = var.container_registry_id
}

# Additional role assignment for the AKS cluster identity
resource "azurerm_role_assignment" "aks_network" {
  principal_id         = azurerm_kubernetes_cluster.main.identity[0].principal_id
  role_definition_name = "Network Contributor"
  scope                = var.subnet_id
}
