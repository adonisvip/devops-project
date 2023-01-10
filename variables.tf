
variable "resource_group_name" {
  type        = string
  description = "This is resource group name"
  default = "k8s_rg"
}

variable "virtual_network_name" {
  type        = string
  description = "This is virtual network name"
  default = "k8s_vtn"
}

variable "subnet_name" {
  type        = string
  description = "This is subnet name"
  default = "k8s_subnet"
}

variable "public_ip_name" {
  type        = string
  description = "This is public ip name"
  default = "k8s-publicip"
}

variable "nsg_name" {
  type        = string
  description = "NSG name in azure"
  default = "k8s-nsg"
}

variable "region" {
  type = string
}

variable "vm_cp_name" {
  type        = string
  description = "VM name"
  default = "k8s"
}

variable "ssh_key_name" {
  type = string
  description = "This is ssh key name"
}

variable "nic_name" {
  type        = string
  description = "NIC name"
  default = "k8s-nic"
}

variable "number_worker" {
  type = number
  description = "This is number worker on k8s"
  default = 1
}

variable "worker_name" {
  type = string
  description = "This is worker name"
  default = "worker"
}

variable "osdisk_name" {
  type = string
  default = "k8s-osdisk"
}

variable "worker_nic_name" {
   type = string
   default = "worker-nic"
}

variable "worker_public_ip_name" {
  type = string
  default = "worker-publicip"
}

variable "vm_size_cp" {
  type = string
  default = "Standard_B2s"
}

variable "vm_size_worker" {
  type = string
}

variable "admin_username" {
  type = string
  description = "This is user use connect ssh"
}

variable "ssh_private_key_name" {
  type = string
}