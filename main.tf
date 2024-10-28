locals {
  # TODO: ipv6 subnets are missing
  len_public_subnets     = max(length(var.public_subnets), )
  len_private_subnets    = max(length(var.private_subnets), )
  len_database_subnets   = max(length(var.database_subnets), )
  len_kubernetes_subnets = max(length(var.kubernetes_subnets), )

  max_subnet_length = max(
    local.len_private_subnets,
    local.len_public_subnets,
    local.len_database_subnets,
    local.len_kubernetes_subnets,
  )

  create_public_subnets     = var.create_public_subnets && local.len_public_subnets > 0
  create_database_subnets   = var.create_database_subnets && local.len_database_subnets > 0
  create_private_subnets    = var.create_private_subnets && local.len_private_subnets > 0
  create_kubernetes_subnets = var.create_kubernetes_subnets && local.len_kubernetes_subnets > 0
}

resource "azurerm_virtual_network" "this" {
  name                = var.name
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  address_space       = [var.cidr]
  dns_servers         = var.dns_servers
  tags                = var.tags
}

#
# public subnet resources
#
resource "azurerm_subnet" "public" {
  count = local.create_public_subnets && length(var.public_subnets) > 0 ? 1 : 0

  name                 = "public-${count.index}"
  address_prefixes     = var.public_subnets
  resource_group_name  = data.azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
}

#
# private subnet resources
#
resource "azurerm_subnet" "private" {
  count = local.create_private_subnets && length(var.private_subnets) > 0 ? 1 : 0

  name                 = "private-${count.index}"
  address_prefixes     = var.private_subnets
  resource_group_name  = data.azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
}

#
# database subnet resources
#
resource "azurerm_subnet" "database" {
  count = local.create_database_subnets && length(var.database_subnets) > 0 ? 1 : 0

  name                 = "database-${count.index}"
  address_prefixes     = var.database_subnets
  resource_group_name  = data.azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
}

#
# kubernetes subnet resources
#
resource "azurerm_subnet" "kubernetes" {
  count = local.create_kubernetes_subnets && length(var.kubernetes_subnets) > 0 ? 1 : 0

  name                 = "kubernetes-${count.index}"
  address_prefixes     = var.kubernetes_subnets
  resource_group_name  = data.azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
}
