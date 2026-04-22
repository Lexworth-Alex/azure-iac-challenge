resource "azurerm_linux_virtual_machine_scale_set" "this" {
  name                = "vmss-${var.name_prefix}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard_B2s"
  instances           = 2
  admin_username      = var.admin_username
  tags                = var.tags

  upgrade_mode = "Manual"

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.public_key_path)
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  custom_data = base64encode(file(var.custom_data_file_path))

  network_interface {
    name    = "nic-${var.name_prefix}"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = var.subnet_id
      application_gateway_backend_address_pool_ids = [
        var.backend_pool_id
      ]
    }
  }
}
