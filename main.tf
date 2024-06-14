resource "azurerm_resource_group" "rg01" {
  for_each = var.rg02
  name     = each.value.resource_group_name
  location = each.value.location
}

resource "azurerm_virtual_network" "vnet" {
  depends_on = [azurerm_resource_group.rg01]

  for_each            = var.vnet
  name                = each.value.vnet_name
  address_space       = each.value.address_space
  location            = each.value.location
  resource_group_name = each.value.resource_group_name


  dynamic "subnet" {
    for_each = each.value.subnets
    content {
      name           = subnet.value.subnet_name
      address_prefix = subnet.value.address_prefix

    }

  }

}


