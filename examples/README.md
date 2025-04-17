<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_gitlab"></a> [gitlab](#requirement\_gitlab) | ~>17.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gitlab_group_module_example"></a> [gitlab\_group\_module\_example](#module\_gitlab\_group\_module\_example) | ../modules/group-module | n/a |
| <a name="module_gitlab_group_module_subgroups"></a> [gitlab\_group\_module\_subgroups](#module\_gitlab\_group\_module\_subgroups) | ../modules/group-module | n/a |
| <a name="module_gitlab_project_module"></a> [gitlab\_project\_module](#module\_gitlab\_project\_module) | ../modules/project-module | n/a |
| <a name="module_gitlab_user_module_example"></a> [gitlab\_user\_module\_example](#module\_gitlab\_user\_module\_example) | ../modules/user-module | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_token"></a> [admin\_token](#input\_admin\_token) | Owner/Maintainer PAT token with the api scope applied. | `string` | n/a | yes |
| <a name="input_base_url"></a> [base\_url](#input\_base\_url) | Base Url for Gitlab Instance | `string` | `"https://gsa-0.gitlab-dedicated.us/api/v4/"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->