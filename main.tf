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

# location            = data.azurerm_resource_group.this.location
# resource_group_name = data.azurerm_resource_group.this.name

resource "azurerm_route_table" "public" {
  count = length(var.public_subnets) > 0 ? length(var.public_subnets) : 0

  name                = "public-${count.index}"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name

  route {
    name           = "public-${count.index}"
    address_prefix = index(var.public_subnets, count.index)
    next_hop_type  = "VirtualAppliance"
  }
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
  service_endpoints    = var.public_service_endpoints
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
  service_endpoints    = var.private_service_endpoints
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
  service_endpoints    = var.database_service_endpoints
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
  service_endpoints    = var.kubernetes_service_endpoints
}
