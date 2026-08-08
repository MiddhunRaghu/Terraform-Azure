variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "MyFirst"
}


resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_group_name}rg"
  location = "centralus"
}

resource "azurerm_service_plan" "asp" {
  name                = "${var.resource_group_name}asp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "F1"
  os_type             = "Linux"
}

resource "azurerm_linux_web_app" "webapp" {
  name                = "${var.resource_group_name}webapp26"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.asp.id
  site_config {
    always_on = false
  }
}

resource "azurerm_linux_web_app_slot" "slot" {
  name           = "${var.resource_group_name}slot"
  app_service_id = azurerm_linux_web_app.webapp.id
  site_config {}
}
