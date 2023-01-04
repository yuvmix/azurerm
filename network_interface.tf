resource "azurerm_network_interface" "dev_nic" {

  count = var.vms_amount

  name                = "dev_nic_${count.index}"
  location            = azurerm_resource_group.dev_rg.location
  resource_group_name = azurerm_resource_group.dev_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.dev_subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.123.1.${count.index + 4}" # first 3 and last 2 addrsses reserved by azure(of each subnet)
    public_ip_address_id          = azurerm_public_ip.dev_ip[count.index].id
  }

  tags = {
    environment = "dev"
  }
}
