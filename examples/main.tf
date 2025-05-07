# Example usage of modules
# Start groups
locals {
  groups         = yamldecode(file("./groups.yaml.sample"))
  group_owners   = { for email, user in local.users["users"] : email => [for slug, customer in local.groups["customers"] : slug if contains(lookup(customer, "owners", []), email)] }
}

module "example-customer-groups" {
  # See how to select revisions https://developer.hashicorp.com/terraform/language/modules/sources#selecting-a-revision
  source = "github.com/cloud-gov/terraform-gitlab-modules//group?ref=SHA"

  groups = { for slug, customer in local.groups["customers"] :
    slug => {
      name                    = customer["name"]
      path                    = slug
      description             = lookup(customer, "description", "")
      visibility_level        = lookup(customer, "visibility", "public")
      register_runner         = customer["runner"]["register"]
      project_creation_level  = "owner"
      subgroup_creation_level = "owner"
    }
  }
}
# End groups

# Start users
locals {
  users = yamldecode(file("./users.yaml.sample"))
}
module "users" {
  source = "github.com/cloud-gov/terraform-gitlab-modules//user?ref=SHA"
  groups = { for slug, role_groups in module.example-customer-groups.role_groups : "${slug}-owner" => role_groups.owner }

  users = { for email, user in local.users["users"] :
    email => {
      name     = user["name"]
      email    = email
      username = lookup(user, "username", split("@", email)[0])
      is_admin = lookup(user, "admin", false)

      groups = { for slug in local.group_owners[email] :
        "${slug}-owner" => {
          access_level = "owner"
        }
      }
    }
  }
}
# End users

# Start Projects
locals {
  projects = yamldecode(file("./projects.yaml.sample"))
}
module "example-projects" {
  source = "github.com/cloud-gov/terraform-gitlab-modules//group?ref=SHA"
  groups = module.example-customer-groups.created_groups
  #Create a configuration project for each top level group
  projects = {
    for key, project in local.projects["projects"] :
    key => {
      name                   = "${project["name"]}"
      namespace_id           = module.example-customer-groups.created_groups[project["namespace"]].id
      approvals_before_merge = 2
      default_branch = "main"
      initialize_with_readme = true
      shared_groups          = {}
      push_rules = {
        member_check = true
      }
    }
  }
  depends_on = [module.example-customer-groups.created_groups]
}

resource "gitlab_branch_protection" "BranchProtect" {
  for_each = module.example-projects.created_projects

  project                = lookup(each.value, "id")
  branch                 = "main"
  push_access_level      = "developer"
  merge_access_level     = "maintainer"
  unprotect_access_level = "admin"
  allow_force_push       = false
}
# End Projects
#Start group membership
locals {
  subgroups = yamldecode(file("./subgroups.yaml"))
  gl_groups = {
    for group in data.gitlab_groups.groups.groups : group.full_path => {
      id   = group.group_id
      name = group.name
      path = group.path
  } }

  gl_users = {
    for user in data.gitlab_users.users.users : user.email => {
      id   = user.id
      name = user.name
  } }
}

module "group_membership" {
  source      = "../group_membership"
  memberships = merge([
    for subgroup in local.subgroups["subgroups"] : {
      for key, member in subgroup.members :
      "${key}" => {
        group_id     = local.gl_groups["${subgroup["parent"]}/${subgroup["name"]}/roles/${member["role"]}s"].id
        user_id      = local.gl_users["${key}"].id
        access_level = member.role
      }
  }]...)

}
# End Group Membership