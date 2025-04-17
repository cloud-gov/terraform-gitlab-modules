<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_gitlab"></a> [gitlab](#requirement\_gitlab) | ~>17.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_gitlab"></a> [gitlab](#provider\_gitlab) | ~>17.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [gitlab_group.group](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_groups"></a> [groups](#input\_groups) | Map for list of groups | <pre>map(object({<br/>    name                              = string<br/>    path                              = string<br/>    auto_devops_enabled               = optional(bool, false)<br/>    description                       = optional(string, "")<br/>    default_branch                    = optional(string, "main")<br/>    emails_enabled                    = optional(bool, true)<br/>    lfs_enabled                       = optional(bool, true)<br/>    mentions_disabled                 = optional(bool, false)<br/>    parent_id                         = number<br/>    project_creation_level            = optional(string, "developer")<br/>    request_access_enabled            = optional(bool, true)<br/>    require_two_factor_authentication = optional(bool, false)<br/>    subgroup_creation_level           = optional(string, "maintainer")<br/>    two_factor_grace_period           = optional(number)<br/>    visibility_level                  = optional(string, "internal")<br/><br/>  }))</pre> | n/a | yes |
| <a name="input_parent_id"></a> [parent\_id](#input\_parent\_id) | Parent group id | `number` | `0` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_created_groups"></a> [created\_groups](#output\_created\_groups) | List of created groups |
<!-- END_TF_DOCS -->