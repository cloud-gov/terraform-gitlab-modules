data "gitlab_groups" "groups" {
  sort = "asc"
}

data "gitlab_users" "users" {
  sort = "asc"
}