
locals {
  # Flatten structure for groups associated with users
  user_membership = flatten([
    for user_key, user in var.users : [
      for group_key, group in user.groups : {
        user_key                      = user_key
        group_key                     = group_key
        user_id                       = gitlab_user.user[user_key].id
        access_level                  = group.access_level
        member_role_id                = group.member_role_id
        skip_subresources_on_destory  = group.skip_subresources_on_destory
        unassign_issuables_on_destroy = group.unassign_issuables_on_destroy
      }
    ]
  ])
}

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

resource "gitlab_group_membership" "group_membership" {
  for_each = {
    for user_membership in local.user_membership : "${user_membership.user_key}.${user_membership.group_key}" => user_membership
  }
  user_id      = each.value.user_id
  group_id     = var.groups[each.value.group_key].id
  access_level = each.value.access_level
}
