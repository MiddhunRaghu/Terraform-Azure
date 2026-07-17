locals {
  nsg_rules = {
    "allow-http" = {
        priority                   = 100
        destination_port_range        = "80"
        description                = "Allow HTTP"
    }
    "allow-https" = {
        priority                   = 110
        destination_port_range        = "443"
        description                = "Allow HTTPS"
    }
  }
}
