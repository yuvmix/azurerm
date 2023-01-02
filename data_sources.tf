data "azurerm_public_ip" "dev_ip_data" {
  name                = azurerm_public_ip.dev_ip.name
  resource_group_name = azurerm_resource_group.dev_rg.name
}

