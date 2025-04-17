
variable "users" {
  description = "Map for list of users"
  type = map(object({

    # required
    name     = string
    username = string
    email    = string

    groups = optional(map(object({
      access_level                  = optional(string)
      member_role_id                = optional(number)
      skip_subresources_on_destory  = optional(bool)
      unassign_issuables_on_destroy = optional(bool)
    })), {})

    # optional
    can_create_group  = optional(bool, false)
    is_admin          = optional(bool, false)
    is_external       = optional(bool, false)
    note              = optional(string)
    password          = optional(string)
    projects_limit    = optional(number)
    reset_password    = optional(bool, true)
    skip_confirmation = optional(bool)
    state             = optional(string)
  }))
}

variable "groups" {
  description = "Map for list of groups"
  type = map(object({
    id                                = number
    name                              = string
    path                              = string
    auto_devops_enabled               = optional(bool, false)
    description                       = optional(string, "")
    default_branch                    = optional(string, "main")
    emails_enabled                    = optional(bool, true)
    lfs_enabled                       = optional(bool, true)
    mentions_disabled                 = optional(bool, false)
    parent_id                         = optional(number, null)
    project_creation_level            = optional(string, "developer")
    request_access_enabled            = optional(bool, true)
    require_two_factor_authentication = optional(bool, false)
    subgroup_creation_level           = optional(string, "maintainer")
    two_factor_grace_period           = optional(number)
    visibility_level                  = optional(string, "internal")
  }))
  default = null
}
