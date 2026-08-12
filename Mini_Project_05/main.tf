resource "azurerm_resource_group" "rg" {
  name     = "azurefunction-rg"
  location = "canadacentral"
}

resource "azurerm_storage_account" "sa" {
  name                     = "azurefunctionsa"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_linux_function_app" "functionapp" {
  name                       = "azurefunctionapp"
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  service_plan_id            = azurerm_service_plan.asp.id
  storage_account_name       = azurerm_storage_account.sa.name
  storage_account_access_key = azurerm_storage_account.sa.primary_access_key

  site_config {
    always_on = true
    application_stack {
      node_version = "18"
    }
  }
}

resource "azurerm_service_plan" "asp" {
  name                = "azurefunction-asp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "Y1"
  os_type             = "Linux"
}
