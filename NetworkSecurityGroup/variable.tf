variable "environment" {
  type    = string
  default = "dev"
}
#List Constraints
variable "allowed_vm_sizes" {
  type    = list(string)
  default = ["Standard_DS1_v2", "Standard_DS2_v2", "Standard_DS3_v2"]
}