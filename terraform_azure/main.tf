provider "azurerm" {
  features {}

  subscription_id = "1c4e8749-9651-495c-a455-309e1201bfb1"
  client_id       = "d631accc-7fbd-4e4d-94e6-aea947e2cb7b"
  client_secret   = "gWy8Q~ILoahGHWq5TwRhDM2GtaIV1~ZX8iirOaon"
  tenant_id       = "fee747b5-9cea-4ce8-b5e7-7b34cb1be686"
}

resource "azurerm_virtual_network" "my_vnet" {
  name                = "myVnet"
  address_space       = ["10.0.0.0/16"]
  location            = "East US"
  resource_group_name = "myResourceGroup"
}
