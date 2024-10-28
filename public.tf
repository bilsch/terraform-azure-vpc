locals {
  create_public_subnets = var.create_public_subnets && local.len_public_subnets > 0
}

resource "azurerm_subnet" "public" {
  count = locals.create_public_subnets && (length(var.public_subnets) > 0) ? length(var.public_subnets) : 0

  name                 = "public-${count.index}"
  address_prefixes     = var.public_subnets[count.index]
  resource_group_name  = data.azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
}
