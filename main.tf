locals {
}

resource "azurerm_virtual_network" "this" {
  name                = var.name
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  address_space       = var.cidr
  tags                = var.tags
}

resource "azurerm_virtual_network_dns_servers" "this" {
  virtual_network_id = azurerm_virtual_network.this.id
  dns_servers        = var.dns_servers
}

#
# public subnet resources
#
resource "azurerm_subnet" "public" {
  count = length(var.public_subnets) > 0 ? 1 : 0

  name                 = "public"
  address_prefixes     = var.public_subnets
  resource_group_name  = data.azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
}

#
# private subnet resources
#
resource "azurerm_subnet" "private" {
  count = length(var.private_subnets) > 0 ? 1 : 0

  name                 = "private"
  address_prefixes     = var.private_subnets
  resource_group_name  = data.azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
}

#
# database subnet resources
#
resource "azurerm_subnet" "database" {
  count = length(var.database_subnets) > 0 ? 1 : 0

  name                 = "database"
  address_prefixes     = var.database_subnets
  resource_group_name  = data.azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
}

#
# kubernetes subnet resources
#
resource "azurerm_subnet" "kubernetes" {
  count = length(var.kubernetes_subnets) > 0 ? 1 : 0

  name                 = "kubernetes"
  address_prefixes     = var.kubernetes_subnets
  resource_group_name  = data.azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
}
