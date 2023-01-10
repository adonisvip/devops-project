resource "azurerm_public_ip" "worker-publicip" {
  count               = local.number_worker
  name                = "${local.worker_public_ip_name}-${count.index+1}"
  resource_group_name = azurerm_resource_group.my_project.name
  location            = azurerm_resource_group.my_project.location
  allocation_method   = "Static"

  tags = {
    environment = "k8s-cluster"
  }
}

resource "azurerm_network_interface" "worker-nic" {
  count                     = local.number_worker
  name                      = "${local.worker_nic_name}-${count.index+1}"
  location                  = azurerm_resource_group.my_project.location
  resource_group_name       = azurerm_resource_group.my_project.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.my_project-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = element(azurerm_public_ip.worker-publicip.*.id,count.index+1)
  }
}

resource "azurerm_network_interface_security_group_association" "nsg-worker" {
    count                     = local.number_worker
    network_interface_id      = element(azurerm_network_interface.worker-nic.*.id, count.index+1)
    network_security_group_id = azurerm_network_security_group.my_project-nsg.id
}

resource "azurerm_linux_virtual_machine" "k8s-worker" {
  count               = local.number_worker
  name                = "${local.worker_name}${count.index +1}"
  resource_group_name = azurerm_resource_group.my_project.name
  location            = azurerm_resource_group.my_project.location
  size                = local.vm_size_worker
  admin_username      = local.admin_username
  network_interface_ids = [element(azurerm_network_interface.worker-nic.*.id, count.index+1),]
  # delete_os_disk_on_termination = true
  # delete_data_disks_on_termination = true

  admin_ssh_key {
    username   = local.admin_username
    public_key = file(local.ssh_key_name)
    # public_key = tls_private_key.myproject-ssh.public_key_openssh
  }

  os_disk {
    name                 = "${local.os_disk_name}-worker-${count.index+1}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  computer_name                   = "${local.worker_name}${count.index+1}"
  disable_password_authentication = true

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.myproject_storage.primary_blob_endpoint
  }

  tags = {
    environment = "k8s-cluster"
  }

	# provisioner "file" {
  #   connection {
  #     host = self.public_ip_address
  #     user = self.admin_username
  #     type = "ssh"
  #     private_key = file(local.ssh_private_key_name)
  #     timeout = "4m"
  #     agent = false
  #   }
  #     source = "examples/script"
  #     destination = "/tmp/script"
  # }

  # provisioner "remote-exec" {
  #   connection {
  #     host = self.public_ip_address
  #     user = self.admin_username
  #     type = "ssh"
  #     private_key = file(local.ssh_private_key_name)
  #     timeout = "4m"
  #     agent = false
  #   }

  #     inline = [
  #     ]
  # }
}
