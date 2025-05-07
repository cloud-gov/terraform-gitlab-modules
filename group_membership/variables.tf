variable "memberships" {
  description = "Map of memberships"
  type = map(object({
    group_id     = number
    user_id      = number
    access_level = string
    })
  )
}

