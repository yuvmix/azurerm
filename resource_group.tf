resource "azurerm_resource_group" "dev_rg" {
  name     = "dev_rg"
  location = var.location

  tags = {
    environment = "dev"
  }
}
