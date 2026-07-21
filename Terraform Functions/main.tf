locals {
  # Assignment 1
  Formatted_name         = lower(replace(var.project_name, " ", "_"))
  
  #Assignment 2
  merged_tags            = merge(var.default_tags, var.environment_tags)

  #Assignment 3
  storage_formatted_name = replace(replace(substr(var.storage_account_name, 0, 23), " ", ""), "@", "")

  #Assignment 4
  formatted_ports        = split(",", (var.port))
  nsg_rules = [for port in local.formatted_ports : {
    name        = "port-${port}"
    port        = port
    description = "Allow inbound traffic on port : ${port}"
    }
  ]

  #Assignment 5
  vm_size = lookup(var.vm_sizes, var.environment, lower("dev"))


  file_status = {
    for file in var.config_path :
    file => fileexists(file) ? "exists" : "not exists"
  }

  file_dirs = {
    for p in var.config_path :
    p => dirname(p)
  }


  #Assignment 9
  concatinate_location = toset(concat(var.user_location, var.default_location))

  convert_value = [for p in var.number : abs(p)]
  max_cost      = max(local.convert_value...)

  current_time   = timestamp()
  formatted_date = formatdate("YYYYMMDD", local.current_time)
  tag_date       = formatdate("DD-MM-YYYY", local.current_time)


  config_content = sensitive(file("./config.json"))
}



resource "azurerm_resource_group" "rg" {
  name     = "${local.Formatted_name}-rg"
  location = "East US"

  tags = local.merged_tags
}

resource "azurerm_storage_account" "storage" {
  name                     = local.storage_formatted_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = local.merged_tags
}

resource "azurerm_network_security_group" "nsg" {
  name                = var.securitygroup_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dynamic "security_rule" {
    for_each = local.nsg_rules
    content {
      name                       = "*"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value.port
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = security_rule.value.description
    }
  }
}
output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}

output "nsg_rules" {
  value = local.nsg_rules
}

output "security_group_name" {
  value = azurerm_network_security_group.nsg.name
}

output "vm_size" {
  value = local.vm_size
}

output "backup_name" {
  value = var.backup
}

output "credentials" {
  value     = var.creds
  sensitive = true
}

output "file_status" {
  value = local.file_status
}

output "dirname" {
  value = local.file_dirs
}

output "concatinate" {
  value = local.concatinate_location
}

output "convert" {
  value = local.convert_value
}

output "max" {
  value = local.max_cost
}

output "formatted_dates" {
  value = local.formatted_date
}

output "config_loaded" {
  value = nonsensitive(jsondecode(local.config_content))
}
