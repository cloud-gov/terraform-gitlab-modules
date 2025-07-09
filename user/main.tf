# Gitlab Users
resource "gitlab_user" "user" {
  for_each = var.users

  name           = each.value.name
  username       = each.value.username
  email          = each.value.email
  reset_password = each.value.reset_password
  # optional
  can_create_group  = each.value.can_create_group
  is_admin          = each.value.is_admin
  is_external       = each.value.is_external
  note              = each.value.note
  password          = each.value.password
  projects_limit    = each.value.projects_limit
  skip_confirmation = each.value.skip_confirmation
  state             = each.value.state
}
