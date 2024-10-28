locals {
  create_database_subnets = var.create_database_subnets && local.len_database_subnets > 0
}

resource "azurerm_subnet" "database" {
  count = locals.create_database_subnets && (length(var.database_subnets) > 0) ? length(var.database_subnets) : 0

  name                 = "database-${count.index}"
  address_prefixes     = var.database_subnets[count.index]
  resource_group_name  = data.azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
}
