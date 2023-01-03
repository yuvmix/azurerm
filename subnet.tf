resource "azurerm_subnet" "dev_subnet" {
  name                 = "dev_subnet"
  resource_group_name  = azurerm_resource_group.dev_rg.name
  virtual_network_name = azurerm_virtual_network.dev_vn.name
  address_prefixes     = var.address_prefixes
  
  tags = {
    environment = "dev"
  } 
}
