
locals {
  gl_groups = {
    for group in var.groups : group.full_path => {
      id = group.id
  } }

  gl_users = {
    for user in data.gitlab_users.users.users : user.username => {
      id   = user.id
      name = user.username
  } }
}

resource "gitlab_group_membership" "group_membership" {
  for_each     = var.memberships
  user_id      = each.value.user_id
  group_id     = local.gl_groups["${each.value.parent_group_path}/${each.value.group_name}/roles/${each.value.access_level}"].id
  access_level = trimsuffix(each.value.access_level, "s")
}
