
variable "memberships" {
  description = "Map of memberships"
  type = map(object({
    group_name        = string
    user_id           = string
    access_level      = string
    parent_group_path = string
    })
  )
}
