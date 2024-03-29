resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "example" {
  name                = var.name
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "public" {
  count               = 3
  name                = "public-subnet-${count.index + 1}"
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes    = ["10.0.${count.index + 1}.0/24"]
}

resource "azurerm_subnet" "private" {
  count               = 3
  name                = "private-subnet-${count.index + 1}"
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes    = ["10.0.${count.index + 4}.0/24"]
}

resource "azurerm_network_security_group" "example" {
  name                = "${var.name}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_security_rule" "allow_http" {
  name                        = "allow_http"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example.name
  network_security_group_name = azurerm_network_security_group.example.name
}

resource "azurerm_virtual_machine_scale_set" "example" {
  name                = var.vmss_name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "Standard_D2s_v3"
  instances           = var.vmss_instance_count
}

output "vmss_id" {
  value = azurerm_virtual_machine_scale_set.example.id
}
