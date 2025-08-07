output "resource_group_name" {
  description = "Name of the created resource group"
  value       = azurerm_resource_group.main.name
}

output "resource_group_id" {
  description = "ID of the created resource group"
  value       = azurerm_resource_group.main.id
}

output "vnet_id" {
  description = "ID of the virtual network"
  value       = azurerm_virtual_network.main.id
}

output "vnet_name" {
  description = "Name of the virtual network"
  value       = azurerm_virtual_network.main.name
}

output "prod_subnet_id" {
  description = "ID of the production subnet"
  value       = azurerm_subnet.prod.id
}

output "prod_subnet_name" {
  description = "Name of the production subnet"
  value       = azurerm_subnet.prod.name
}

output "test_subnet_id" {
  description = "ID of the test subnet"
  value       = azurerm_subnet.test.id
}

output "test_subnet_name" {
  description = "Name of the test subnet"
  value       = azurerm_subnet.test.name
}

output "dev_subnet_id" {
  description = "ID of the development subnet"
  value       = azurerm_subnet.dev.id
}

output "dev_subnet_name" {
  description = "Name of the development subnet"
  value       = azurerm_subnet.dev.name
}

output "admin_subnet_id" {
  description = "ID of the admin subnet"
  value       = azurerm_subnet.admin.id
}

output "admin_subnet_name" {
  description = "Name of the admin subnet"
  value       = azurerm_subnet.admin.name
}

output "location" {
  description = "Azure region where resources are deployed"
  value       = azurerm_resource_group.main.location
}
