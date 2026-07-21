variable "project_name" {
  type    = string
  default = "Project ALPHA Resource"
}

variable "default_tags" {
  type = map(string)
  default = {
    company    = "TechCorp"
    managed_by = "terraform"
  }
}
variable "environment_tags" {
  type = map(string)
  default = {
    environment = "production"
    cost_center = "cc-123"
  }
}

variable "storage_account_name" {
  type    = string
  default = "middhunraghu @ storage accountname"
}

variable "securitygroup_name" {
  type    = string
  default = "securegroup"
}

variable "port" {
  type    = string
  default = "80,443,8080,3306"
}


variable "environment" {
  type        = string
  description = "Environment name"
  default     = "dev"
  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "Enter the valid env: dev, test, or prod"
  }
}

variable "vm_sizes" {
  type = map(string)
  default = {
    dev  = "Standard_B1s"
    test = "Standard_B2s"
    prod = "Standard_B4ms"
  }
}

variable "vm_size" {
  type    = string
  default = "standard_D2s_v3"
  validation {
    condition     = length(var.vm_size) >= 2 && length(var.vm_size) <= 20
    error_message = "VM size must be between 2 and 20 characters."
  }

  validation {
    condition     = strcontains(lower(var.vm_size), "standard")
    error_message = "VM size must start with 'Standard'"
  }
}

variable "backup" {
  default     = "daily_backup"
  type        = string
  description = "backup name must ends with '_backup'"
  validation {
    condition     = endswith(var.backup, "_backup")
    error_message = "backup name must ends with '_backup'"
  }
}

variable "creds" {
  default     = "xyz123"
  type        = string
  description = "enter the password"
  sensitive   = true
}


variable "config_path" {
  type = list(string)
  default = ["./main.tf",
  "./variable.tf"]
}


variable "user_location" {
  type    = list(string)
  default = ["eastus", "westus", "eastus"]
}

variable "default_location" {
  type    = list(string)
  default = ["centralus"]
}

variable "number" {
  type    = list(number)
  default = [-50, 100, 75, 200]
}

variable "current_time" {
  type    = string
  default = null
}
