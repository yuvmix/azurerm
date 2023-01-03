output "public_ip" {
  value = azurerm_linux_virtual_machine.dev_lvm.public_ip_address
}

output "lb_public_ip" {
  value = azurerm_public_ip.dev_lb_ip.ip_address
}
