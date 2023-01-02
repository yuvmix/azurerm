resource "azurerm_network_security_group" "dev_sg" {
  name                = "dev_sg"
  location            = azurerm_resource_group.dev_rg.location
  resource_group_name = azurerm_resource_group.dev_rg.name

  tags = {
    environment = "dev"
  }
}
