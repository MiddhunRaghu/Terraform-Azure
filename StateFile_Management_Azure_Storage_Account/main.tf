terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }

    backend "azurerm" {
      resource_group_name  = "tfstate_management-rg"
      storage_account_name = "statemanagement18347"
      container_name       = "tfstate-container"
      key                  = "demo.terraform.tfstate"
  }

  required_version = ">= 1.0.0"
}

provider "azurerm" {
  features {

  }
}

resource "azurerm_resource_group" "rg" {
  name     = "MyFirstResourceGroup"
  location = "eastus"
}

resource "azurerm_storage_account" "sa" {
  name                     = "my1staccount2026"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "Terraform Demo"
  }
}
