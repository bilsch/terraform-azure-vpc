locals {
  create_private_subnets = var.create_private_subnets && local.len_private_subnets > 0
}

resource "azurerm_subnet" "private" {
  count = locals.create_private_subnets && (length(var.private_subnets) > 0) ? length(var.private_subnets) : 0

  name                 = "private-${count.index}"
  address_prefixes     = var.private_subnets[count.index]
  resource_group_name  = data.azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
}
