resource "azurerm_public_ip" "dev_ip" {
  name                = "dev_ip"
  resource_group_name = azurerm_resource_group.dev_rg.name
  location            = azurerm_resource_group.dev_rg.location
  allocation_method   = "Dynamic"

  tags = {
    environment = "dev"
  }
}
