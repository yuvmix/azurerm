resource "azurerm_public_ip" "dev_lb_ip" {
  name = "dev_lb_ip"
  location = azurerm_resource_group.dev_rg.location
  resource_group_name = azurerm_resource_group.dev_rg.name
  allocation_method = "Static"
}

resource "azurerm_lb" "dev_lb" {
  name = "dev_lb"
  location = azurerm_resource_group.dev_rg.location
  resource_group_name = azurerm_resource_group.name
  
  fronted_ip_configuration {
    name = "dev_lb_public_ip"
    public_ip_address_id_ = azurerm_public_ip.dev_lb_ip.id
  }
}

resource  "azurerm_lb_backend_address_pool" "dev_lb_address_pool" {
  name = "dev_lb_address_pool"
  loadbalancer_id = azurerm_lb.dev_lb.id
}

resource "azurerm_lb_backend_address_pool_address" "dev_lb_address_pool_address" {
  name = "dev_lb_address_pool_address"
  backend_address_pool_id = azurerm_lb_backend_address_pool.dev_lb_address_pool.id
  virtual_network_id = azurerm_virtual_network.dev_vn.id
}
  
