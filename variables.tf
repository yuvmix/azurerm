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
variable "inbound_tcp_allow_rules" {
  default = {
    http = {
      # name                   = "http"
      priority               = 200
      destination_port_range = 80
    },
    ssh = {
      # name                   = "ssh"
      priority               = 150
      destination_port_range = 22
    }
  }
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
  default = "~/.ssh/id_rsa"
}

# load_balancer.tf
variable "lb_ip_allocation_method" {
  default = "Static"
}

variable "lb_sku" {
  default = "Standard"
}

# used to create pools to the lb and for each pool its rule and probe
# when create new pool should notice azurerm_lb_backend_address_pool_address resources to give appropriate pool
variable "lb_pools_rules_probes" {
  default = {
    http = {
      # name                   = "http" # for the pool, rule and probe
      frontend_port = 80
      backend_port  = 80    # rule and probe
      protocol      = "Tcp" # rule and probe
    },
  }
}
