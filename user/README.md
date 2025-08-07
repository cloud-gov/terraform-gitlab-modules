<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.10 |
| <a name="requirement_gitlab"></a> [gitlab](#requirement\_gitlab) | ~>18.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_gitlab"></a> [gitlab](#provider\_gitlab) | ~>18.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [gitlab_user.user](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/user) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_users"></a> [users](#input\_users) | Map for list of users | <pre>map(object({<br/><br/>    # required<br/>    name     = string<br/>    username = string<br/>    email    = string<br/><br/>    # optional<br/>    can_create_group      = optional(bool, false)<br/>    is_admin              = optional(bool, false)<br/>    is_external           = optional(bool, false)<br/>    reset_password        = optional(bool, false)<br/>    force_random_password = optional(bool, true)<br/>    note                  = optional(string)<br/>    projects_limit        = optional(number)<br/>    skip_confirmation     = optional(bool)<br/>    state                 = optional(string)<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_created_users"></a> [created\_users](#output\_created\_users) | List of created users |
<!-- END_TF_DOCS -->