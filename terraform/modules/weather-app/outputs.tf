# Container Registry Outputs
output "acr_login_server" {
  description = "Login server for the Azure Container Registry"
  value       = azurerm_container_registry.main.login_server
}

output "acr_admin_username" {
  description = "Admin username for the Azure Container Registry"
  value       = azurerm_container_registry.main.admin_username
  sensitive   = true
}

output "acr_admin_password" {
  description = "Admin password for the Azure Container Registry"
  value       = azurerm_container_registry.main.admin_password
  sensitive   = true
}

output "acr_id" {
  description = "ID of the Azure Container Registry"
  value       = azurerm_container_registry.main.id
}

# AKS Test Cluster Outputs
output "aks_test_cluster_name" {
  description = "Name of the AKS test cluster"
  value       = module.aks_test.cluster_name
}

output "aks_test_cluster_id" {
  description = "ID of the AKS test cluster"
  value       = module.aks_test.cluster_id
}

output "aks_test_kube_config" {
  description = "Kubernetes config for test cluster"
  value       = module.aks_test.kube_config
  sensitive   = true
}

# AKS Production Cluster Outputs
output "aks_prod_cluster_name" {
  description = "Name of the AKS production cluster"
  value       = module.aks_prod.cluster_name
}

output "aks_prod_cluster_id" {
  description = "ID of the AKS production cluster"
  value       = module.aks_prod.cluster_id
}

output "aks_prod_kube_config" {
  description = "Kubernetes config for production cluster"
  value       = module.aks_prod.kube_config
  sensitive   = true
}

# Redis Cache Outputs
output "redis_test_hostname" {
  description = "Hostname of the test Redis cache"
  value       = azurerm_redis_cache.test.hostname
}

output "redis_test_port" {
  description = "Port of the test Redis cache"
  value       = azurerm_redis_cache.test.port
}

output "redis_test_ssl_port" {
  description = "SSL port of the test Redis cache"
  value       = azurerm_redis_cache.test.ssl_port
}

output "redis_test_primary_access_key" {
  description = "Primary access key for test Redis cache"
  value       = azurerm_redis_cache.test.primary_access_key
  sensitive   = true
}

output "redis_prod_hostname" {
  description = "Hostname of the production Redis cache"
  value       = azurerm_redis_cache.prod.hostname
}

output "redis_prod_port" {
  description = "Port of the production Redis cache"
  value       = azurerm_redis_cache.prod.port
}

output "redis_prod_ssl_port" {
  description = "SSL port of the production Redis cache"
  value       = azurerm_redis_cache.prod.ssl_port
}

output "redis_prod_primary_access_key" {
  description = "Primary access key for production Redis cache"
  value       = azurerm_redis_cache.prod.primary_access_key
  sensitive   = true
}
