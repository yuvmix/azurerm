# health probe to check the addresses in the pool
resource "azurerm_lb_probe" "dev_lb_probe" {

  for_each = var.lb_pools_rules_probes

  loadbalancer_id = azurerm_lb.dev_lb.id
  name            = "dev_lb_${each.key}_probe"
  port            = each.value["backend_port"]
  protocol        = each.value["protocol"]
}
