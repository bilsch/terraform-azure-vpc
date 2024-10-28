#
# VPC outputs
#
output "vpc_id" {
  value = azurerm_virtual_network.this.id
}

output "vpc_name" {
  value = azurerm_virtual_network.this.name
}

output "vpc_subnet" {
  value = azurerm_virtual_network.this.subnet
}

#
# Public subnet outputs
#
output "public_ids" {
  value = azurerm_subnet.public.*.id
}

output "public_names" {
  value = azurerm_subnet.public.*.name
}

output "public_service_endpoints" {
  value = azurerm_subnet.public.*.service_endpoints
}

#
# private subnet outputs
#
output "private_ids" {
  value = azurerm_subnet.private.*.id
}

output "private_names" {
  value = azurerm_subnet.private.*.name
}

output "private_service_endpoints" {
  value = azurerm_subnet.private.*.service_endpoints
}

#
# database subnet outputs
#
output "database_ids" {
  value = azurerm_subnet.database.*.id
}

output "database_names" {
  value = azurerm_subnet.database.*.name
}

output "database_service_endpoints" {
  value = azurerm_subnet.database.*.service_endpoints
}

#
# kubernetes subnet outputs
#
output "kubernetes_ids" {
  value = azurerm_subnet.kubernetes.*.id
}

output "kubernetes_names" {
  value = azurerm_subnet.kubernetes.*.name
}

output "kubernetes_service_endpoints" {
  value = azurerm_subnet.kubernetes.*.service_endpoints
}
