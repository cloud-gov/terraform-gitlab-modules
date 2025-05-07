<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.10 |
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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_memberships"></a> [memberships](#input\_memberships) | Map of memberships | <pre>map(object({<br/>    group_id = number<br/>    user_id = number<br/>    access_level = string    <br/>  })<br/>  )</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->