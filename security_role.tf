resource "azurerm_network_security_rule" "dev_sr" {

  for_each = toset([ "http", "ssh"])

  name                        = "dev_sr_${each.key}"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = each.key 
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.dev_rg.name
  network_security_group_name = azurerm_network_security_group.dev_sg.name
}
