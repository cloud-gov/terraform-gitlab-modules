variable "users" {
  description = "Map for list of users"
  type = map(object({

    # required
    name     = string
    username = string
    email    = string

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
