variable "location" {
  description = "Azure region"
  default     = "East US"
}

variable "my_public_ip" {
  description = "Your public IP address (with /32)"
  type        = string
}

variable "bastion_ssh_pubkey" {
  description = "SSH public key used for bastion access"
  type        = string
}
