# the creation of addresses pool itself so it could have addresses in it
resource "azurerm_lb_backend_address_pool" "dev_lb_address_pool" {

  for_each = var.lb_pools_rules_probes

  name            = "dev_lb_${each.key}_address_pool"
  loadbalancer_id = azurerm_lb.dev_lb.id
}
