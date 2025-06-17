
locals {
  gl_groups = {
    for group in var.groups : group.path => {
      id   = group.id
      name = group.name
      path = group.path
  } }

  gl_users = {
    for user in data.gitlab_users.users.users : user.username => {
      id   = user.id
      name = user.username
  } }
}

resource "gitlab_group_membership" "group_membership" {
  for_each     = var.memberships
  user_id      = local.gl_users["${each.value.user_name}"].id
  group_id     = local.gl_groups["${each.value.parent_group_path}/${each.value.group_name}/roles/${each.value.access_level}"].id
  access_level = trimsuffix(each.value.access_level, "s")
}
