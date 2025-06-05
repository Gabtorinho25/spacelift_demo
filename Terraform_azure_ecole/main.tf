terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
  required_version = ">= 1.0.0"
}

provider "azurerm" {
  features {}

  subscription_id = "34980b86-905c-48be-8e76-fd0debe129ab"
  client_id       = "6403fc16-323b-4817-8583-2acf2c0876bd"
  client_secret   = "GMb8Q~nGdd2olgm2vkoiBBsbQm5_lPaE1WQv_c3Z"
  tenant_id       = "108bc864-cdf5-4ec3-8b7c-4eb06be1b41d"
}

variable "resource_group_name" {
  type        = string
  description = "Nom du groupe de ressources Azure"
  default     = "RG-azure-td"
}

variable "location" {
  type        = string
  description = "Région Azure où les ressources seront déployées"
  default     = "eastus"
}

variable "vnet_name" {
  type        = string
  description = "Nom du virtual network (VNet)"
  default     = "vnet-td"
}

variable "address_space" {
  type        = list(string)
  description = "Plage d'adresses pour le VNet"
  default     = ["10.0.0.0/16"]
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}
