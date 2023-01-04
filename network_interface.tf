resource "azurerm_network_interface" "dev_nic" {

  count = var.vms_amount # take down line

  name                = "dev_nic_${count.index}"
  location            = azurerm_resource_group.dev_rg.location
  resource_group_name = azurerm_resource_group.dev_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.dev_subnet[floor(count.index / 250)].id # take down []
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.123.${floor(count.index / 250)}.${count.index + 4}" # first 4 and last one  can be ${count.index + 4} 
    # public_ip_address_id          = azurerm_public_ip.dev_ip[count.index].id # open
  }

  tags = {
    environment = "dev"
  }
}
