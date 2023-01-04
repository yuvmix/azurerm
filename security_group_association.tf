# associate between subnet to sg
resource "azurerm_subnet_network_security_group_association" "dev_sga" {

  count = ceil(var.vms_amount / 250) # take down line

  subnet_id                 = azurerm_subnet.dev_subnet[count.index].id # take down []
  network_security_group_id = azurerm_network_security_group.dev_sg.id
}
