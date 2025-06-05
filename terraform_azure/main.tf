provider "azurerm" {
  features {}

  subscription_id = "1c4e8749-9651-495c-a455-309e1201bfb1"
  client_id       = "9cfae9bf-f49a-4802-a332-6a4e3b2410f9"
  client_secret   = "7TU8Q~-So3UBDcmAlNqOain5U.yGF_gPCcQO~bY~"
  tenant_id       = "fee747b5-9cea-4ce8-b5e7-7b34cb1be686"
}

resource "azurerm_virtual_network" "my_vnet" {
  name                = "myVnet"
  address_space       = ["10.0.0.0/16"]
  location            = "East US"
  resource_group_name = "myResourceGroup"
}
