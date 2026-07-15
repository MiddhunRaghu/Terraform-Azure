resource "azurerm_resource_group" "example" {
  name     = "${var.prefix}-resources"
  location = var.allowed_location[1]
}

resource "azurerm_storage_account" "example" {
  # lifecycle {
  #   create_before_destroy = true
  #   prevent_destroy       = true
  #   ignore_changes        = [tags]
  # }
  count                    = length(var.storage_account_names)
  name                     = tolist(var.storage_account_names)[count.index]
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "Terraform Demo"
  }
}
