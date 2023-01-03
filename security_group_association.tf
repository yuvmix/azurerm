resource "azurerm_subnet_network_security_group_association" "dev_sga" {
  subnet_id                 = azurerm_subnet.dev_subnet.id
  network_security_group_id = azurerm_network_security_group.dev_sg.id
 
  tags = {
    environment = "dev"
  } 
}
