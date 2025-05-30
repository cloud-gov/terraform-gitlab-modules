
locals {
  gl_groups = {
    for group in data.gitlab_groups.groups.groups : group.full_path => {
      id   = group.group_id
      name = group.name
      path = group.path
  } }

  gl_users = {
    for user in data.gitlab_users.users.users : user.email => {
      id   = user.id
      name = user.name
  } }

  # Flatten structure for groups associated with users
  # user_membership = flatten([
  #   for group_key, group in var.groups : [
  #     for member_key, member in groups.members : {
  #       member_key                    = member_key
  #       group_key                     = group_key
  #       user_id                       = member.user_id
  #       access_level                  = member.access_level
  #     }
  #   ]
  # ])
}

resource "gitlab_group_membership" "group_membership" {
  for_each     = var.memberships
  user_id      = local.gl_users["${each.value.user_name}"].id
  group_id     = local.gl_groups["${each.value.parent}/${each.value.group_name}/roles/${each.value.access_level}"].id
  access_level = each.value.access_level

}
