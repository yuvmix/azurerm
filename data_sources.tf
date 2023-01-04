/*
data "azurerm_public_ip" "dev_ip_data" {

  count = var.vms_amount

  name                = azurerm_public_ip.dev_ip[count.index].name
  resource_group_name = azurerm_resource_group.dev_rg.name
}
*/
