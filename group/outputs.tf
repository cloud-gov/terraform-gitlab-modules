output "created_groups" {
  description = "Map of created group_name => group"
  value       = gitlab_group.group
}

output "role_groups" {
  description = "Map of created role-based groups"
  value = { for slug, group in var.groups :
    slug => {
      owner     = gitlab_group.owner_role[slug]
      developer = gitlab_group.developer_role[slug]
      reporter  = gitlab_group.reporter_role[slug]
    }
  }
}

output "registered_runners" {
  description = "Map of registered group_name => gitlab_user_runner"
  value       = gitlab_user_runner.group_runner
}

output "all_groups" {
  description = "Map of all created groups"
  value = merge([for slug, group in gitlab_group.group : {
    (group.full_path)                             = group
    (gitlab_group.owner_role[slug].full_path)     = gitlab_group.owner_role[slug]
    (gitlab_group.developer_role[slug].full_path) = gitlab_group.developer_role[slug]
    (gitlab_group.reporter_role[slug].full_path)  = gitlab_group.reporter_role[slug]
  }]...)
}
