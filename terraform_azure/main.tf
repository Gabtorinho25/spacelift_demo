provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "my_rg" {
  name     = "myResourceGroup"
  location = "East US"
}

resource "azurerm_virtual_network" "my_vnet" {
  name                = "myVnet"
  address_space       = ["10.0.0.0/16"]
  location            = "East US"
  resource_group_name = "myResourceGroup"
}
