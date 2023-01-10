terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.36.0"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
  location                = var.region
  resource_group_name     = var.resource_group_name
  virtual_network_name    = var.virtual_network_name
  subnet_name             = var.subnet_name
  public_ip_name          = var.public_ip_name
  nsg_name                = var.nsg_name
  vm_cp_name              = var.vm_cp_name
  vm_size_cp              = var.vm_size_cp
  vm_size_worker          = var.vm_size_worker
  admin_username          = var.admin_username
  ssh_key_name            = var.ssh_key_name
  nic_name                = var.nic_name
  ssh_private_key_name    = var.ssh_private_key_name
  number_worker           = var.number_worker
  worker_public_ip_name   = var.worker_public_ip_name
  worker_nic_name         = var.worker_nic_name
  worker_name             = var.worker_name
  os_disk_name            = var.osdisk_name
}

# module "run-vm-command" {
#   source  = "craigthackerx/run-vm-command/azurerm"
#   version = "1.0.1"
#   # insert the 4 required variables here
# }
