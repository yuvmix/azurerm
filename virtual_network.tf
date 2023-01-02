resource "azurerm_virtual_network" "dev_vn" {
  name = "dev_vn"
  resource_group_name = azurerm_resource_group.dev_rg.name
  location = azurerm_resource_group.dev_rg.location
  address_space = ["10.123.0.0/16"]
  
  tags = {
    environment = "dev"
  }
}
