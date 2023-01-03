resource "azurerm_public_ip" "dev_ip" {

  count = var.vms_amount

  name                = "dev_ip_${count.index}"
  resource_group_name = azurerm_resource_group.dev_rg.name
  location            = azurerm_resource_group.dev_rg.location
  allocation_method   = "Static"

  tags = {
    environment = "dev"
  }
}
