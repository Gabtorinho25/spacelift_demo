output "bastion_public_ip" {
  description = "Public IP of the bastion VM"
  value       = azurerm_public_ip.bastion_ip.ip_address
}
