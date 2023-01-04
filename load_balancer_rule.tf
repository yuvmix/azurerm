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
