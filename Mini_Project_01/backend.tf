terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate_management-rg"
    storage_account_name = "statemanagement22529"
    container_name       = "tfstate-container"
    key                  = "demo.terraform.tfstate"
  }
}
