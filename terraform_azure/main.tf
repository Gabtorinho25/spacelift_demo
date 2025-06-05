provider "azurerm" {
  features {}

  subscription_id = "34980b86-905c-48be-8e76-fd0debe129ab"
  client_id       = "6403fc16-323b-4817-8583-2acf2c0876bd"
  client_secret   = "1425f552-984a-4c4f-b029-eef8e64e7f67"
  tenant_id       = "108bc864-cdf5-4ec3-8b7c-4eb06be1b41d"
}

resource "azurerm_virtual_network" "my_vnet" {
  name                = "myVnet"
  address_space       = ["10.0.0.0/16"]
  location            = "East US"
  resource_group_name = "myResourceGroup"
}
