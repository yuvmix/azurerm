# how to add address to the address pool
resource "azurerm_lb_backend_address_pool_address" "dev_lb_address_pool_address" {

  count = var.vms_amount

  name                    = "dev_lb_address_pool_address_${count.index}"
  backend_address_pool_id = azurerm_lb_backend_address_pool.dev_lb_address_pool["http"].id
  virtual_network_id      = azurerm_virtual_network.dev_vn.id # should be the same vnet of the address
  ip_address              = azurerm_network_interface.dev_nic[count.index].private_ip_address
}
