# We only look up our resource group - must be created before using this module
data "azurerm_resource_group" "this" {
  name = var.name
}
