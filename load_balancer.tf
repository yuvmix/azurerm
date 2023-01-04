resource "azurerm_public_ip" "dev_lb_ip" {
  name                = "dev_lb_ip"
  location            = azurerm_resource_group.dev_rg.location
  resource_group_name = azurerm_resource_group.dev_rg.name
  allocation_method   = var.lb_ip_allocation_method
  sku                 = var.lb_sku

  tags = {
    environment = "dev"
  }
}

resource "azurerm_lb" "dev_lb" {
  name                = "dev-lb"
  location            = azurerm_resource_group.dev_rg.location
  resource_group_name = azurerm_resource_group.dev_rg.name
  sku                 = var.lb_sku

  # the configuration of the recieved ip of the lb
  frontend_ip_configuration {
    name                 = azurerm_public_ip.dev_lb_ip.name
    public_ip_address_id = azurerm_public_ip.dev_lb_ip.id
  }

  tags = {
    environment = "dev"
  }
}

# the creation of addresses pool itself so it could have addresses in it
resource "azurerm_lb_backend_address_pool" "dev_lb_address_pool" {

  for_each = var.lb_pools_rules_probes

  name            = "dev_lb_${each.key}_address_pool"
  loadbalancer_id = azurerm_lb.dev_lb.id
}

# health probe to check the addresses in the pool
resource "azurerm_lb_probe" "dev_lb_probe" {

  for_each = var.lb_pools_rules_probes

  loadbalancer_id = azurerm_lb.dev_lb.id
  name            = "dev_lb_${each.key}_probe"
  port            = each.value["backend_port"]
  protocol        = each.value["protocol"]
}

# rule to address conectivity to the pool from the frontend ip of the lb
resource "azurerm_lb_rule" "dev_lb_rule" {

  for_each = var.lb_pools_rules_probes

  loadbalancer_id                = azurerm_lb.dev_lb.id
  name                           = "dev_lb_${each.key}_rule"
  protocol                       = each.value["protocol"]
  frontend_port                  = each.value["frontend_port"]
  backend_port                   = each.value["backend_port"]
  frontend_ip_configuration_name = azurerm_public_ip.dev_lb_ip.name
  probe_id                       = azurerm_lb_probe.dev_lb_probe[each.key].id                         # should attach the probe here so the rule will apply it
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.dev_lb_address_pool[each.key].id] # which pools to activate the rule on
}

# how to add address to the address pool
resource "azurerm_lb_backend_address_pool_address" "dev_lb_address_pool_address" {

  count = var.vms_amount

  name                    = "dev_lb_address_pool_address_${count.index}"
  backend_address_pool_id = azurerm_lb_backend_address_pool.dev_lb_address_pool["http"].id
  virtual_network_id      = azurerm_virtual_network.dev_vn.id # should be the same vnet of the address
  ip_address              = azurerm_network_interface.dev_nic[count.index].private_ip_address
}
