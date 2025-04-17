# Example usage of modules
# Start customer groups
locals {
  groups         = yamldecode(file("./groups.yaml.sample"))
  group_owners   = { for email, user in local.users["users"] : email => [for slug, customer in local.groups["customers"] : slug if contains(lookup(customer, "owners", []), email)] }
}

module "example-customer-groups" {
  source = "../modules/group-module"

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

# Start users
locals {
  users = yamldecode(file("./users.yaml.sample"))
}
module "users" {
  source = "../modules/user-module"
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
  source = "../modules/project-module"
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
# End Customer Config Projects

