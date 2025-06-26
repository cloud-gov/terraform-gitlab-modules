
variable "memberships" {
  description = "Map of memberships"
  type = map(object({
    group_id     = string
    user_id      = string
    access_level = string
    })
  )
}
