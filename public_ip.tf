resource "azurerm_public_ip" "dev_ip" {
  name = "dev_ip"
  resource_group_name = azurerm_resource_group.dev_sg.name
  location = azurerm_resource_group.dev_sg.location
  allocation_method = "Static"
  
  tags = {
    environment = "dev"
  }
}
