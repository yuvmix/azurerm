resource "azurerm_lb" "dev_lb" {
  name                = "dev-lb"
  location            = azurerm_resource_group.dev_rg.location
  resource_group_name = azurerm_resource_group.dev_rg.name
  sku                 = var.lb_sku

  # the configuration of the recieved ip of the lb
  frontend_ip_configuration {
    name                 = azurerm_public_ip.dev_lb_ip.name
    public_ip_address_id = azurerm_public_ip.dev_lb_ip.id
  }

  tags = {
    environment = "dev"
  }
}
