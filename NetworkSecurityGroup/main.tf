resource "azurerm_resource_group" "nsg" {
  name     = "nsg-resource-group"
  location = "East US"
}

resource "azurerm_network_security_group" "nsg" {
  name                = var.environment == "dev" ? "nsg-dev" : "nsg-stage"
  location            = azurerm_resource_group.nsg.location
  resource_group_name = azurerm_resource_group.nsg.name

  dynamic "security_rule" {
    for_each = local.nsg_rules
    content {
      name                       = security_rule.key
      priority                   = security_rule.value.priority
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = security_rule.value.description
    }
  }
}

output "demo" {
  value = [for count in local.nsg_rules : count.description]
}

output "splat" {
  value = var.allowed_vm_sizes[*]
}
