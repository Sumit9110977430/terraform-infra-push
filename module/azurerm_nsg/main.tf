resource "azurerm_network_security_group" "titunsg" {
  name                = var.azurerm_network_security_group
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "titunsg"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}