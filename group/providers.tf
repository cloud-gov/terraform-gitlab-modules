terraform {
  required_version = "~> 1.10"
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "~>18.0"
    }
  }
}
