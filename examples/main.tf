# Example usage of modules
# Start groups
locals {
  groups       = yamldecode(file("./groups.yaml.sample"))
  group_owners = { for email, user in local.users["users"] : email => [for slug, customer in local.groups["customers"] : slug if contains(lookup(customer, "owners", []), email)] }
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
  source = "github.com/cloud-gov/terraform-gitlab-modules//project?ref=SHA"
  groups = module.example-customer-groups.created_groups
  #Create a configuration project for each top level group
  projects = {
    for key, project in local.projects["projects"] :
    key => {
      name                   = "${project["name"]}"
      namespace_id           = module.example-customer-groups.created_groups[project["namespace"]].id
      approvals_before_merge = 2
      default_branch         = "main"
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
}
module "customer-subgroups" {
  # See how to select revisions https://developer.hashicorp.com/terraform/language/modules/sources#selecting-a-revision
  source = "github.com/cloud-gov/terraform-gitlab-modules//group?ref=SHA"
  groups = { for slug, subgroup in local.subgroups["subgroups"] :
    slug => {
      name             = subgroup["name"]
      path             = slug
      parent_id        = local.gl_groups[subgroup["parent"]].id
      description      = lookup(subgroup, "description", "")
      visibility_level = lookup(subgroup, "visibility", "public")
      #register_runner         = subgroup["runner"]["register"]
      project_creation_level  = "owner"
      subgroup_creation_level = "owner"
    }
  }
}
locals {
  gm = flatten([
    for subgroup_key, subgroup in local.subgroups["subgroups"] : [
      for member_key, member in subgroup.members : [
        for key in member : {
          group_name        = subgroup_key
          user_name         = key
          role              = member_key
          parent_group_path = subgroup.parent
        }
      ]
    ]
  ])
}
module "group_membership" {
  source = "github.com/cloud-gov/terraform-gitlab-modules//group_membership?ref=SHA"
  memberships = {
    for group_member in local.gm :
    "${group_member.user_name}" => {
      group_name        = group_member.group_name
      user_name         = group_member.user_name
      access_level      = group_member.role
      parent_group_path = group_member.parent_group_path
  } }
}
# End Group Membership