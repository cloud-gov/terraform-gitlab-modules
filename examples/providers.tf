terraform {
  required_version = "~> 1.0"
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "~>17.0"
    }
    cloudfoundry = {
      source  = "cloudfoundry/cloudfoundry"
      version = ">= 1.2.0"
    }
    cloudfoundry-community = {
      source  = "cloudfoundry-community/cloudfoundry"
      version = "0.53.1"
    }
  }
}

provider "gitlab" {
  token    = var.admin_token
  base_url = "https://${var.gitlab_host}/api/v4/"
}

provider "cloudfoundry" {
}
provider "cloudfoundry-community" {
  api_url  = "https://api.fr.cloud.gov"
  user     = var.cf_user
  password = var.cf_password
}
