
variable "memberships" {
  description = "Map of memberships"
  type = map(object({
    group_name   = string
    user_name    = string
    access_level = string
    parent       = string
    })
  )
}

