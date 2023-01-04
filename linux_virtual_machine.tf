resource "azurerm_linux_virtual_machine" "dev_lvm" {

  count = var.vms_amount

  name                  = "dev-lvm-${count.index}"
  resource_group_name   = azurerm_resource_group.dev_rg.name
  location              = azurerm_resource_group.dev_rg.location
  size                  = var.lvm_size
  admin_username        = var.username
  network_interface_ids = [azurerm_network_interface.dev_nic[count.index].id]

  # attribute so you can run scripts as the machine created without the need of provision
  custom_data = filebase64(var.custom_data_file_path)

  admin_ssh_key {
    username   = var.username
    public_key = file(var.public_key_path_file)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
/*
  # script to structure the info of the vm so could ssh easly check the other scripts
  provisioner "local-exec" {
    command = templatefile(var.templatefile_template_path, {
      hostname     = self.public_ip_address,
      user         = var.username,
      identityfile = var.identityfile
    })

    interpreter = ["bash", "-c"] # var.host_os =="windows" ? ["Powershell", "-Command"] : ["bash", "-c"]
  }
*/
  tags = {
    environment = "dev"
  }
}
