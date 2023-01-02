resource "azurerm_network_interface" "dev_nic" {
  name                = "dev_nic"
  location            = azurerm_resource_group.dev_rg.location
  resource_group_name = azurerm_resource_group.dev_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.dev_subnet.id
    private_ip_address_allocation = "Static"
    public_ip_address_id          = azurerm_public_ip.dev_ip.id
  }

  tags = {
    environment = "dev"
  }
}
