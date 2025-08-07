terraform {
  required_version = "~> 1.10.0"
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "~>18.0.0"
    }
    cloudfoundry = {
      source  = "cloudfoundry/cloudfoundry"
      version = "~>1.7, !=1.8.0"
    }
  }
}

provider "gitlab" {
  token    = var.admin_token
  base_url = "https://${var.gitlab_host}/api/v4/"
}

provider "cloudfoundry" {}
