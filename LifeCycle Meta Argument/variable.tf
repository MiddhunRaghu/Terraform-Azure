variable "environment" {
  type    = string
  default = "Terraform Demo"
}

variable "prefix" {
  type    = string
  default = "Thirsty-Lion"
}

variable "is_delete" {
  type        = bool
  description = "the default behaviour to os disk upon a vm termination"
  default     = true
}

variable "allowed_location" {
  type    = list(string)
  default = ["West Europe", "East US", "Central US", "North Europe"]
}

#map Constraints
variable "resource_tags" {
  type = map(string)
  default = {
    "environment" = "Terraform Demo"
    "managed-by"  = "Terraform"
    "department"  = "Devops"
  }
}

#Tuple Constraints
variable "network_config" {
  type        = tuple([string, string, number])
  description = "Network Configuration tuple [VNet Address,Subnet Address,Subnet Prefix]"
  default     = ["10.0.0.0/16", "10.0.2.0", 24]
}

#List Constraints
variable "allowed_vm_sizes" {
  type    = list(string)
  default = ["Standard_DS1_v2", "Standard_DS2_v2", "Standard_DS3_v2"]
}

#Object Constraints
variable "vm_config" {
  type = object({
    size      = string
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  description = "Virtual machine configuration"
  default = {
    size      = "Standard_DS1_v2"
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

variable "storage_account_names" {
  type    = set(string)
  default = ["cafestorage5", "cafestorage6"]
}
