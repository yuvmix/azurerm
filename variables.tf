# resource_group.tf
variable "location" {
  default = "West Europe"
}

# virtual_network.tf
variable "vn_address_space" {
  default = ["10.123.0.0/16"]
}

# subnet.tf
variable "address_prefixes" {
  default = ["10.123.1.0/24"]
}

# public_ip.tf
variable "ip_allocation_method" {
  default = "Static"
}

# security rule.tf
variable "rule_protocol_set" {
  default = toset(["http", "ssh"])
}

# linux_virtual_machine.tf 
variable "vms_amount" {
  default = 2
}

variable "lvm_size" {
  default = "Standard_F2"
}

variable "username" {
  default = "adminuser"
}

variable "custom_data_file_path" {
  default = "~/azurerm/scripts/custom_data.tpl"
}

variable "public_key_path_file" {
  default = "~/.ssh/id_rsa.pub"
}

variable "templatefile_template_path" {
  default = "scripts/my_linux_ssh_script.tpl"
}

variable "identityfile" {
  default =  "~/.ssh/id_rsa"
}
