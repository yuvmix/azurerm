resource "azurerm_subnet" "dev_subnet" {

  count = ceil(var.vms_amount / 250) # take down line

  name                 = "dev_subnet"
  resource_group_name  = azurerm_resource_group.dev_rg.name
  virtual_network_name = azurerm_virtual_network.dev_vn.name
  address_prefixes     = [join("", [substr(var.vn_address_space[0], 0, 6), ".${count.index}", ".0/24"])] # can be var.address_prefixes
}
