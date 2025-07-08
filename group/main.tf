# Gitlab Group
resource "gitlab_group" "group" {
  for_each = var.groups

  # required
  name = each.value.name
  path = each.value.path

  # optional
  parent_id                         = lookup(each.value, "parent_id")
  auto_devops_enabled               = lookup(each.value, "auto_devops_enabled")
  description                       = lookup(each.value, "description")
  emails_enabled                    = lookup(each.value, "emails_enabled")
  lfs_enabled                       = lookup(each.value, "lfs_enabled")
  default_branch                    = lookup(each.value, "default_branch")
  mentions_disabled                 = lookup(each.value, "mentions_disabled")
  project_creation_level            = lookup(each.value, "project_creation_level")
  request_access_enabled            = lookup(each.value, "request_access_enabled")
  require_two_factor_authentication = lookup(each.value, "require_two_factor_authentication")
  subgroup_creation_level           = lookup(each.value, "subgroup_creation_level")
  visibility_level                  = lookup(each.value, "visibility_level")
}

resource "gitlab_group" "roles_group" {
  for_each = var.groups

  name = "Roles"
  path = "roles"

  parent_id               = gitlab_group.group[each.key].id
  auto_devops_enabled     = false
  description             = "Roles group for ${each.value.name}"
  request_access_enabled  = false
  project_creation_level  = "noone"
  subgroup_creation_level = "owner"
}

resource "gitlab_group" "owner_role" {
  for_each = var.groups

  name = "Owners"
  path = "owners"

  parent_id               = gitlab_group.roles_group[each.key].id
  auto_devops_enabled     = false
  description             = "Owners group for ${each.value.name}"
  request_access_enabled  = false
  project_creation_level  = "noone"
  subgroup_creation_level = "owner"
}
resource "gitlab_group_share_group" "group_owners" {
  for_each = var.groups

  group_id       = gitlab_group.group[each.key].id
  share_group_id = gitlab_group.owner_role[each.key].id
  group_access   = "owner"
}

resource "gitlab_group" "developer_role" {
  for_each = var.groups

  name = "Developers"
  path = "developers"

  parent_id               = gitlab_group.roles_group[each.key].id
  auto_devops_enabled     = false
  description             = "Developers group for ${each.value.name}"
  request_access_enabled  = false
  project_creation_level  = "noone"
  subgroup_creation_level = "owner"
}
resource "gitlab_group_share_group" "group_developers" {
  for_each = var.groups

  group_id       = gitlab_group.group[each.key].id
  share_group_id = gitlab_group.developer_role[each.key].id
  group_access   = "developer"
}

resource "gitlab_group" "reporter_role" {
  for_each = var.groups

  name = "Reporters"
  path = "reporters"

  parent_id               = gitlab_group.roles_group[each.key].id
  auto_devops_enabled     = false
  description             = "Reporters group for ${each.value.name}"
  request_access_enabled  = false
  project_creation_level  = "noone"
  subgroup_creation_level = "owner"
}
resource "gitlab_group_share_group" "group_reporters" {
  for_each = var.groups

  group_id       = gitlab_group.group[each.key].id
  share_group_id = gitlab_group.reporter_role[each.key].id
  group_access   = "reporter"
}

locals {
  runner_groups = { for name, group in var.groups : name => group.runner_config if group.register_runner }
}
resource "gitlab_user_runner" "group_runner" {
  for_each = local.runner_groups

  runner_type = "group_type"
  description = "${gitlab_group.group[each.key].name} Runner"
  group_id    = gitlab_group.group[each.key].id
  untagged    = each.value.untagged
  tag_list    = each.value.tags
  paused      = each.value.paused
}
