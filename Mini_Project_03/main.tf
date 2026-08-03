data "azuread_domains" "domains" {
  only_initial = true
}

resource "azuread_user" "users" {
  for_each = { for user in local.users : user.first_name => user }

  user_principal_name   = format("%s%s@%s", substr(each.value.first_name, 0, 1), lower(each.value.last_name), local.domain_name)
  password              = format("%s%s%s!", lower(each.value.last_name), substr(each.value.first_name, 0, 1), local.domain_name)
  display_name          = "${each.value.first_name} ${each.value.last_name}"
  force_password_change = true
  department            = each.value.department
  job_title             = each.value.job_title
}
locals {
  domain_name = data.azuread_domains.domains.domains[0].domain_name
  users       = csvdecode(file("users.csv"))
}

output "domain_name" {
  value = local.domain_name
}

output "users" {
  value = [for user in local.users : "${user.first_name} ${user.last_name}"]
}

output "user_principal_names" {
  value = [for user in azuread_user.users : user.user_principal_name]
}
