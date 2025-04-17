variable "admin_token" {
  description = "Owner/Maintainer PAT token with the api scope applied."
  type        = string
  sensitive   = true
}

variable "gitlab_host" {
  description = "Hostname for Gitlab Instance"
  type        = string
}

variable "cf_developer_email" {
  type        = string
  description = "Your cloud.gov email, you must be an OrgManager"
}

variable "cf_user" {
  type        = string
  description = "username for a regular SpaceDeployer service account"
}
variable "cf_password" {
  type        = string
  sensitive   = true
  description = "password for the cf_user service account"
}
