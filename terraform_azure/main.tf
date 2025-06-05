provider "azurerm" {
  features {}

  subscription_id = "34980b86-905c-48be-8e76-fd0debe129ab"
  client_id       = "6403fc16-323b-4817-8583-2acf2c0876bd"
  client_secret   = "pnP8Q~mXGjusA-RKBGOH6d2DHYRvhLSY3LWs7bvD"
  tenant_id       = "108bc864-cdf5-4ec3-8b7c-4eb06be1b41d"
}

resource "azurerm_virtual_network" "my_vnet" {
  name                = "myVnet"
  address_space       = ["10.0.0.0/16"]
  location            = "East US"
  resource_group_name = "myResourceGroup"
}
