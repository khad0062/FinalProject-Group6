# Network Outputs
output "resource_group_name" {
  description = "Name of the main resource group"
  value       = module.network.resource_group_name
}

output "vnet_name" {
  description = "Name of the virtual network"
  value       = module.network.vnet_name
}

# Container Registry Outputs
output "acr_login_server" {
  description = "Login server for the Azure Container Registry"
  value       = module.weather_app.acr_login_server
}

# AKS Cluster Outputs
output "aks_test_cluster_name" {
  description = "Name of the AKS test cluster"
  value       = module.weather_app.aks_test_cluster_name
}

output "aks_prod_cluster_name" {
  description = "Name of the AKS production cluster"
  value       = module.weather_app.aks_prod_cluster_name
}

# Redis Cache Outputs
output "redis_test_hostname" {
  description = "Hostname of the test Redis cache"
  value       = module.weather_app.redis_test_hostname
}

output "redis_prod_hostname" {
  description = "Hostname of the production Redis cache"
  value       = module.weather_app.redis_prod_hostname
}

# Instructions
output "next_steps" {
  description = "Next steps for deployment"
  value = <<-EOT
    
    Next Steps:
    1. Set up the Terraform backend by running: terraform apply -target=module.backend
    2. Update main.tf to uncomment and configure the backend block
    3. Initialize Terraform with the backend: terraform init
    4. Configure GitHub Actions secrets with Azure credentials
    5. Push your code and create pull requests for testing
    
    Important URLs:
    - ACR Login Server: ${module.weather_app.acr_login_server}
    - Test AKS Cluster: ${module.weather_app.aks_test_cluster_name}
    - Prod AKS Cluster: ${module.weather_app.aks_prod_cluster_name}
  EOT
}
