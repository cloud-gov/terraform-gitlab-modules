

resource "gitlab_group_membership" "group_membership" {
  for_each     = var.memberships
  user_id      = each.value.user_id
  group_id     = each.value.group_id
  access_level = trimsuffix(each.value.access_level, "s")
}
