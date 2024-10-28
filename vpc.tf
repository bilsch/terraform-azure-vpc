resource "azurerm_virtual_network" "this" {
  name                = var.name
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  address_space       = [var.cidr]
  dns_servers         = var.dns_servers
  tags                = var.tags

}
