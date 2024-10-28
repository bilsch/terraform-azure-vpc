locals {
  create_kubernetes_subnets = var.create_kubernetes_subnets && local.len_kubernetes_subnets > 0
}

resource "azurerm_subnet" "kubernetes" {
  count = locals.create_kubernetes_subnets && (length(var.kubernetes_subnets) > 0) ? length(var.kubernetes_subnets) : 0

  name                 = "kubernetes-${count.index}"
  address_prefixes     = var.kubernetes_subnets[count.index]
  resource_group_name  = data.azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
}
