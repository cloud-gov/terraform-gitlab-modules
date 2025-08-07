
locals {
  #Flatten structure for projects associated with groups
  project_groups = flatten([
    for project_key, project in var.projects : [
      for group_key, group in project.shared_groups : {
        project_key  = project_key
        group_key    = group_key
        project_id   = gitlab_project.project[project_key].id
        group_access = group.group_access
      }
    ]
  ])
}

resource "gitlab_project" "project" {
  for_each = var.projects
  #required
  name = each.value.name

  #optional
  allow_merge_on_skipped_pipeline                  = each.value.allow_merge_on_skipped_pipeline
  allow_pipeline_trigger_approve_deployment        = each.value.allow_pipeline_trigger_approve_deployment
  analytics_access_level                           = each.value.analytics_access_level
  approvals_before_merge                           = each.value.approvals_before_merge
  archive_on_destroy                               = each.value.archive_on_destroy
  archived                                         = each.value.archived
  auto_cancel_pending_pipelines                    = each.value.auto_cancel_pending_pipelines
  auto_devops_deploy_strategy                      = each.value.auto_devops_deploy_strategy
  auto_devops_enabled                              = each.value.auto_devops_enabled
  autoclose_referenced_issues                      = each.value.autoclose_referenced_issues
  avatar                                           = each.value.avatar
  avatar_hash                                      = each.value.avatar_hash
  build_git_strategy                               = each.value.build_git_strategy
  build_timeout                                    = each.value.build_timeout
  builds_access_level                              = each.value.builds_access_level
  ci_config_path                                   = each.value.ci_config_path
  ci_default_git_depth                             = each.value.ci_default_git_depth
  ci_forward_deployment_enabled                    = each.value.ci_forward_deployment_enabled
  ci_pipeline_variables_minimum_override_role      = each.value.ci_pipeline_variables_minimum_override_role
  ci_restrict_pipeline_cancellation_role           = each.value.ci_restrict_pipeline_cancellation_role
  ci_separated_caches                              = each.value.ci_separated_caches
  container_registry_access_level                  = each.value.container_registry_access_level
  default_branch                                   = each.value.default_branch
  description                                      = each.value.description
  emails_enabled                                   = each.value.emails_enabled
  environments_access_level                        = each.value.environments_access_level
  external_authorization_classification_label      = each.value.external_authorization_classification_label
  feature_flags_access_level                       = each.value.feature_flags_access_level
  forked_from_project_id                           = each.value.forked_from_project_id
  forking_access_level                             = each.value.forking_access_level
  group_runners_enabled                            = each.value.group_runners_enabled
  group_with_project_templates_id                  = each.value.group_with_project_templates_id
  import_url                                       = each.value.import_url
  import_url_password                              = each.value.import_url_password
  import_url_username                              = each.value.import_url_username
  infrastructure_access_level                      = each.value.infrastructure_access_level
  initialize_with_readme                           = each.value.initialize_with_readme
  issues_access_level                              = each.value.issues_access_level
  issues_enabled                                   = each.value.issues_enabled
  issues_template                                  = each.value.issues_template
  keep_latest_artifact                             = each.value.keep_latest_artifact
  lfs_enabled                                      = each.value.lfs_enabled
  merge_commit_template                            = each.value.merge_commit_template
  merge_method                                     = each.value.merge_method
  merge_pipelines_enabled                          = each.value.merge_pipelines_enabled
  merge_requests_access_level                      = each.value.merge_requests_access_level
  merge_requests_enabled                           = each.value.merge_requests_enabled
  merge_requests_template                          = each.value.merge_requests_template
  merge_trains_enabled                             = each.value.merge_trains_enabled
  mirror                                           = each.value.mirror
  mirror_overwrites_diverged_branches              = each.value.mirror_overwrites_diverged_branches
  mirror_trigger_builds                            = each.value.mirror_trigger_builds
  model_experiments_access_level                   = each.value.model_experiments_access_level
  model_registry_access_level                      = each.value.model_registry_access_level
  monitor_access_level                             = each.value.monitor_access_level
  mr_default_target_self                           = each.value.mr_default_target_self
  namespace_id                                     = each.value.namespace_id
  only_allow_merge_if_all_discussions_are_resolved = each.value.only_allow_merge_if_all_discussions_are_resolved
  only_allow_merge_if_pipeline_succeeds            = each.value.only_allow_merge_if_pipeline_succeeds
  only_mirror_protected_branches                   = each.value.only_mirror_protected_branches
  packages_enabled                                 = each.value.packages_enabled
  pages_access_level                               = each.value.pages_access_level
  path                                             = each.value.path
  pre_receive_secret_detection_enabled             = each.value.pre_receive_secret_detection_enabled
  prevent_merge_without_jira_issue                 = each.value.prevent_merge_without_jira_issue
  printing_merge_request_link_enabled              = each.value.printing_merge_request_link_enabled
  public_builds                                    = each.value.public_builds
  public_jobs                                      = each.value.public_jobs
  releases_access_level                            = each.value.releases_access_level
  remove_source_branch_after_merge                 = each.value.remove_source_branch_after_merge
  repository_access_level                          = each.value.repository_access_level
  repository_storage                               = each.value.repository_storage
  request_access_enabled                           = each.value.request_access_enabled
  requirements_access_level                        = each.value.requirements_access_level
  resolve_outdated_diff_discussions                = each.value.resolve_outdated_diff_discussions
  restrict_user_defined_variables                  = each.value.restrict_user_defined_variables
  security_and_compliance_access_level             = each.value.security_and_compliance_access_level
  shared_runners_enabled                           = each.value.shared_runners_enabled
  skip_wait_for_default_branch_protection          = each.value.skip_wait_for_default_branch_protection
  snippets_access_level                            = each.value.snippets_access_level
  snippets_enabled                                 = each.value.snippets_enabled
  squash_commit_template                           = each.value.squash_commit_template
  squash_option                                    = each.value.squash_option
  suggestion_commit_message                        = each.value.suggestion_commit_message
  template_project_id                              = each.value.template_project_id
  topics                                           = each.value.topics
  use_custom_template                              = each.value.use_custom_template
  visibility_level                                 = each.value.visibility_level
  wiki_access_level                                = each.value.wiki_access_level
  wiki_enabled                                     = each.value.wiki_enabled

  dynamic "container_expiration_policy" {
    for_each = lookup(each.value, "container_expiration_policy", null) != null ? [1] : []
    content {
      cadence           = lookup(each.value.container_expiration_policy, "cadence", null)
      enabled           = lookup(each.value.container_expiration_policy, "enabled", null)
      keep_n            = lookup(each.value.container_expiration_policy, "keep_n", null)
      name_regex_delete = lookup(each.value.container_expiration_policy, "name_regex_delete", null)
      name_regex_keep   = lookup(each.value.container_expiration_policy, "name_regex_keep", null)
      older_than        = lookup(each.value.container_expiration_policy, "older_than", null)
    }
  }

  dynamic "push_rules" {
    for_each = lookup(each.value, "push_rules", null) != null ? [1] : []
    content {
      author_email_regex            = lookup(each.value.push_rules, "author_email_regex", null)
      branch_name_regex             = lookup(each.value.push_rules, "branch_name_regex", null)
      commit_committer_check        = lookup(each.value.push_rules, "commit_committer_check", null)
      commit_committer_name_check   = lookup(each.value.push_rules, "commit_committer_name_check", null)
      commit_message_regex          = lookup(each.value.push_rules, "commit_message_regex", null)
      commit_message_negative_regex = lookup(each.value.push_rules, "commit_message_negative_regex", null)
      deny_delete_tag               = lookup(each.value.push_rules, "deny_delete_tag", null)
      file_name_regex               = lookup(each.value.push_rules, "file_name_regex", null)
      max_file_size                 = lookup(each.value.push_rules, "max_file_size", 10000)
      member_check                  = lookup(each.value.push_rules, "member_check", null)
      prevent_secrets               = lookup(each.value.push_rules, "prevent_secrets", true)
      reject_non_dco_commits        = lookup(each.value.push_rules, "reject_non_dco_commits", null)
      reject_unsigned_commits       = lookup(each.value.push_rules, "reject_unsigned_commits", true)
    }
  }

}

resource "gitlab_project_share_group" "gitlab_project_groups" {
  for_each = {
    for project_groups in local.project_groups : "${project_groups.project_key}.${project_groups.group_key}" => project_groups
  }
  project      = each.value.project_id
  group_id     = var.groups[each.value.group_key].id
  group_access = each.value.group_access
}
