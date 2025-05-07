
# locals {
#   # Flatten structure for groups associated with users
#   user_membership = flatten([
#     for group_key, group in var.groups : [
#       for member_key, member in groups.members : {
#         member_key                    = member_key
#         group_key                     = group_key
#         user_id                       = member.user_id
#         access_level                  = member.access_level
#       }
#     ]
#   ])
# }

resource "gitlab_group_membership" "group_membership" {
  for_each     = var.memberships
  user_id      = each.value.user_id
  group_id     = each.value.group_id
  access_level = each.value.access_level
}
