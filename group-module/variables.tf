
variable "groups" {
  description = "Map for list of groups"
  type = map(object({
    name                              = string
    path                              = string
    auto_devops_enabled               = optional(bool, false)
    description                       = optional(string, "")
    default_branch                    = optional(string, "main")
    emails_enabled                    = optional(bool, true)
    lfs_enabled                       = optional(bool, true)
    mentions_disabled                 = optional(bool, false)
    parent_id                         = optional(number, null)
    project_creation_level            = optional(string, "noone")
    request_access_enabled            = optional(bool, true)
    require_two_factor_authentication = optional(bool, false)
    subgroup_creation_level           = optional(string, "noone")
    two_factor_grace_period           = optional(number)
    visibility_level                  = optional(string, "internal")
    register_runner                   = optional(bool, false)
  }))
}
