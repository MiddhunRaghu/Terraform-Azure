resource "azuread_group" "engineering" {
  display_name     = "Educational Department"
  security_enabled = true
}

resource "azuread_group_member" "education" {
  for_each = { for u in azuread_user.users : u.mail_nickname => u if u.department == "Education" }

  group_object_id  = azuread_group.engineering.object_id
  member_object_id = each.value.object_id
}

resource "azuread_group" "managers" {
  display_name     = "Education - Managers"
  security_enabled = true
}

resource "azuread_group_member" "managers" {
  for_each = { for u in azuread_user.users : u.mail_nickname => u if u.department == "Manager" }

  group_object_id  = azuread_group.managers.object_id
  member_object_id = each.value.object_id
}

resource "azuread_group" "engineers" {
  display_name     = " Education - Engineers"
  security_enabled = true
}

resource "azuread_group_member" "engineers" {
  for_each = { for u in azuread_user.users : u.mail_nickname => u if u.department == "Engineers" }

  group_object_id  = azuread_group.engineers.object_id
  member_object_id = each.value.object_id
}
