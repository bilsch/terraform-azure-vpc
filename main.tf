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
# Nat gateway support
#
resource "azurerm_public_ip" "this" {
  name                = "${var.name}-example-PIP"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_nat_gateway" "this" {
  name                = "${var.name}-nat-Gateway"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  sku_name            = "Standard"
}

resource "azurerm_nat_gateway_public_ip_association" "this" {
  nat_gateway_id       = azurerm_nat_gateway.this.id
  public_ip_address_id = azurerm_public_ip.this.id
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

resource "azurerm_subnet_nat_gateway_association" "public" {
  subnet_id      = azurerm_subnet.public[0].id
  nat_gateway_id = azurerm_nat_gateway.this.id
}

# resource "azurerm_route_table" "public" {
#   count = length(var.public_subnets) > 0 ? length(var.public_subnets) : 0

#   name                = "public-${count.index}"
#   location            = data.azurerm_resource_group.this.location
#   resource_group_name = data.azurerm_resource_group.this.name

#   route {
#     name           = "public-${count.index}"
#     address_prefix = element(var.public_subnets, count.index)
#     next_hop_type  = "VnetLocal"
#   }
# }

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

resource "azurerm_subnet_nat_gateway_association" "private" {
  subnet_id      = azurerm_subnet.private[0].id
  nat_gateway_id = azurerm_nat_gateway.this.id
}

# resource "azurerm_route_table" "private" {
#   count = length(var.private_subnets) > 0 ? length(var.private_subnets) : 0

#   name                = "private-${count.index}"
#   location            = data.azurerm_resource_group.this.location
#   resource_group_name = data.azurerm_resource_group.this.name

#   route {
#     name           = "private-${count.index}"
#     address_prefix = element(var.private_subnets, count.index)
#     next_hop_type  = "VnetLocal"
#   }
# }

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

resource "azurerm_subnet_nat_gateway_association" "database" {
  subnet_id      = azurerm_subnet.database[0].id
  nat_gateway_id = azurerm_nat_gateway.this.id
}

# resource "azurerm_route_table" "database" {
#   count = length(var.database_subnets) > 0 ? length(var.database_subnets) : 0

#   name                = "database-${count.index}"
#   location            = data.azurerm_resource_group.this.location
#   resource_group_name = data.azurerm_resource_group.this.name

#   route {
#     name           = "database-${count.index}"
#     address_prefix = element(var.database_subnets, count.index)
#     next_hop_type  = "VnetLocal"
#   }
# }

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

resource "azurerm_subnet_nat_gateway_association" "kubernetes" {
  subnet_id      = azurerm_subnet.kubernetes[0].id
  nat_gateway_id = azurerm_nat_gateway.this.id
}

# resource "azurerm_route_table" "kubernetes" {
#   count = length(var.kubernetes_subnets) > 0 ? length(var.kubernetes_subnets) : 0

#   name                = "kubernetes-${count.index}"
#   location            = data.azurerm_resource_group.this.location
#   resource_group_name = data.azurerm_resource_group.this.name

#   route {
#     name           = "kubernetes-${count.index}"
#     address_prefix = element(var.kubernetes_subnets, count.index)
#     next_hop_type  = "VnetLocal"
#   }
# }
