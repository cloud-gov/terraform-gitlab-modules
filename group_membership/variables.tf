
# variable "groups" {
#   description = "Map for list of groups & members"
#   type = map(object({
#     id = number
#     members = map(object({
#       email        = string
#       access_level = string
#       user_id      = number
#     }))
#   }))
#   default = null
# }

# variable "users" {
#   description = "Map for list of users"
#   type = map(object({

#     # required
#     name     = string
#     username = string
#     email    = string

#     groups = optional(map(object({
#       group_path                    = optional(string)
#       access_level                  = optional(string)
#       member_role_id                = optional(number)
#       skip_subresources_on_destory  = optional(bool)
#       unassign_issuables_on_destroy = optional(bool)
#     })), {})

#     # optional
#     can_create_group  = optional(bool, false)
#     is_admin          = optional(bool, false)
#     is_external       = optional(bool, false)
#     note              = optional(string)
#     password          = optional(string)
#     projects_limit    = optional(number)
#     reset_password    = optional(bool, true)
#     skip_confirmation = optional(bool)
#     state             = optional(string)
#   }))
# }

# variable "users" {
#   description = "Map for list of users"
#   type = map(object({
#     email = string
#     role  = string
#     # optional
#   }))
# }

variable "memberships" {
  description = "Map of memberships"
  type = map(object({
    group_id = number
    user_id = number
    access_level = string    
  })
  )
}

