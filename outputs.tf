
output "control-plane" {
  value = azurerm_linux_virtual_machine.k8s-control-plane.public_ip_address
}

output "worker-ip" {
  value = "${azurerm_public_ip.worker-publicip.*.ip_address}"
}

output "private_ip_cp" {
  value = azurerm_network_interface.my_project-nic.private_ip_address
}
output "private_ip_worker" {
  value = "${azurerm_network_interface.worker-nic.*.private_ip_address}"
}
# output "ip-private" {
#   value = "${azurerm_network_interface.worker-nic.count.index+1.private_ip_address}"
# }