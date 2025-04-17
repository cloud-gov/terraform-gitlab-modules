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
| [gitlab_group_membership.group_membership](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/group_membership) | resource |
| [gitlab_user.user](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/user) | resource |
| [gitlab_group.group](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/data-sources/group) | data source |
| [gitlab_user.user](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/data-sources/user) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_users"></a> [users](#input\_users) | Map for list of users | <pre>map(object({<br/>  <br/>  #required<br/>  name              = string<br/>  username          = string<br/>  email             = string<br/>  <br/>  groups = map(object({<br/>    full_path = string<br/>    access_level = optional(string)<br/>    member_role_id = optional(number)<br/>    skip_subresources_on_destory = optional(bool)<br/>    unassign_issuables_on_destroy = optional(bool)<br/>  }))<br/><br/>  #optional<br/>  can_create_group  = optional(bool) <br/>  is_admin          = optional(bool)<br/>  is_external       = optional(bool)<br/>  note              = optional(string)<br/>  password          = optional(string)<br/>  projects_limit    = optional(number)<br/>  reset_password    = optional(bool, true)<br/>  skip_confirmation = optional(bool)<br/>  state             = optional(string)<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_created_users"></a> [created\_users](#output\_created\_users) | List of created users |
<!-- END_TF_DOCS -->