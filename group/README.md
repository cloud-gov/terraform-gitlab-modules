<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.10 |
| <a name="requirement_gitlab"></a> [gitlab](#requirement\_gitlab) | ~>18.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_gitlab"></a> [gitlab](#provider\_gitlab) | ~>18.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [gitlab_group.developer_role](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/group) | resource |
| [gitlab_group.group](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/group) | resource |
| [gitlab_group.owner_role](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/group) | resource |
| [gitlab_group.reporter_role](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/group) | resource |
| [gitlab_group.roles_group](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/group) | resource |
| [gitlab_group_share_group.group_developers](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/group_share_group) | resource |
| [gitlab_group_share_group.group_owners](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/group_share_group) | resource |
| [gitlab_group_share_group.group_reporters](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/group_share_group) | resource |
| [gitlab_user_runner.group_runner](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/user_runner) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_groups"></a> [groups](#input\_groups) | Map for list of groups | <pre>map(object({<br/>    name                              = string<br/>    path                              = string<br/>    auto_devops_enabled               = optional(bool, false)<br/>    description                       = optional(string, "")<br/>    default_branch                    = optional(string, "main")<br/>    emails_enabled                    = optional(bool, true)<br/>    lfs_enabled                       = optional(bool, true)<br/>    mentions_disabled                 = optional(bool, false)<br/>    parent_id                         = optional(number, null)<br/>    project_creation_level            = optional(string, "noone")<br/>    request_access_enabled            = optional(bool, true)<br/>    require_two_factor_authentication = optional(bool, false)<br/>    subgroup_creation_level           = optional(string, "noone")<br/>    two_factor_grace_period           = optional(number)<br/>    visibility_level                  = optional(string, "internal")<br/>    register_runner                   = optional(bool, false)<br/>    runner_config = optional(object({<br/>      tags     = optional(list(string), [])<br/>      untagged = optional(bool, true)<br/>      paused   = optional(bool, false)<br/>    }), {})<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_all_groups"></a> [all\_groups](#output\_all\_groups) | Map of all created groups |
| <a name="output_created_groups"></a> [created\_groups](#output\_created\_groups) | Map of created group\_name => group |
| <a name="output_registered_runners"></a> [registered\_runners](#output\_registered\_runners) | Map of registered group\_name => gitlab\_user\_runner |
| <a name="output_role_groups"></a> [role\_groups](#output\_role\_groups) | Map of created role-based groups |
<!-- END_TF_DOCS -->