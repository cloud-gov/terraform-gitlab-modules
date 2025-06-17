
variable "memberships" {
  description = "Map of memberships"
  type = map(object({
    group_name        = string
    user_name         = string
    access_level      = string
    parent_group_path = string
    })
  )
}

variable "groups" {
  description = "Map of groups"
  type = map(object({
    full_path  = string
    group_name = string
    id         = string
    })
  )
}