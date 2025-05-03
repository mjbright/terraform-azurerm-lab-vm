
# If working in your own environment, you may want to create a resource_group
# In this lab environment you are limited to your ```studentN``` resource_group
#
#resource "azurerm_resource_group rg {
#  location = var.location
#  name     = var.resource_group
#}

resource azurerm_network_interface nic {
  name                = "${var.prefix}-nic"
  location            = var.location
  #resource_group_name   = azurerm_resource_group.rg.name
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "${var.prefix}-ipconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }

  tags = merge(var.tags, { source = "terraform", type = "vm" } )
}

resource azurerm_public_ip pip {
  name                         = "${var.prefix}-ip"
  location                     = var.location
  #resource_group_name   = azurerm_resource_group.rg.name
  resource_group_name = var.resource_group
  allocation_method            = "Static"
  domain_name_label            = lower( var.dns_name )

  tags = merge(var.tags, { source = "terraform", type = "vm" } )
}

resource azurerm_linux_virtual_machine vm {
  name                  = "${var.prefix}-vm"
  location              = var.location
  #resource_group_name  = azurerm_resource_group.rg.name
  resource_group_name   = var.resource_group
  size                  = var.vm_size
  network_interface_ids = [ azurerm_network_interface.nic.id ]

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  os_disk {
   name                  = "${var.hostname}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  computer_name  = var.hostname
  admin_username = var.admin_username
  disable_password_authentication = true

  admin_ssh_key {
     username   = var.admin_username
     public_key = file( join( "", [ pathexpand(var.admin_priv_key), ".pub" ] ) )
  }

  tags = merge(var.tags, { source = "terraform", type = "vm" } )
}

