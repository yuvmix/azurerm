resource "azurerm_public_ip" "dev_lb_ip" {
  name                = "dev_lb_ip"
  location            = azurerm_resource_group.dev_rg.location
  resource_group_name = azurerm_resource_group.dev_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  
  tags = {
    environment = "dev"
  }
}

resource "azurerm_lb" "dev_lb" {
  name                = "dev-lb"
  location            = azurerm_resource_group.dev_rg.location
  resource_group_name = azurerm_resource_group.dev_rg.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "dev_lb_public_ip"
    public_ip_address_id = azurerm_public_ip.dev_lb_ip.id
  }
  
  tags = {
    environment = "dev"
  }
}

resource "azurerm_lb_backend_address_pool" "dev_lb_address_pool" {
  name            = "dev_lb_address_pool"
  loadbalancer_id = azurerm_lb.dev_lb.id
  
  tags = {
    environment = "dev"
  }
}

resource "azurerm_lb_backend_address_pool_address" "dev_lb_address_pool_address" {

  count = var.vms_amount

  name                    = "dev_lb_address_pool_address_${count.index}"
  backend_address_pool_id = azurerm_lb_backend_address_pool.dev_lb_address_pool.id
  virtual_network_id      = azurerm_virtual_network.dev_vn.id
  ip_address              = azurerm_network_interface.dev_nic[count.index].private_ip_address
  
  tags = {
    environment = "dev"
  }
}

resource "azurerm_lb_probe" "dev_lb_http_probe" {
  loadbalancer_id = azurerm_lb.dev_lb.id
  name            = "dev_lb_http_probe"
  port            = 80
  protocol        = "Tcp"
  
  tags = {
    environment = "dev"
  }
}

resource "azurerm_lb_rule" "dev_lb_http_rule" {
  loadbalancer_id                = azurerm_lb.dev_lb.id
  name                           = "dev_lb_http_rule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "dev_lb_public_ip"
  probe_id                       = azurerm_lb_probe.dev_lb_http_probe.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.dev_lb_address_pool.id]
  
  tags = {
    environment = "dev"
  }
}
