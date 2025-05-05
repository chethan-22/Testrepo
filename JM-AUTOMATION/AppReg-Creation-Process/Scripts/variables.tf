variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "github-federated" {
  type    = string
  default = "NO"
}

variable "github-environment" {
  type = string
}

variable "github-repo" {
  type = string
}

variable "rbac-enabled" {
  type    = string
  default = "NO"
}

variable "rbac-roles" {
  type    = string
  default = ""
}

variable "rbac-scopes" {
  type    = string
  default = ""
}


locals {
  github-federated = var.github-federated == "YES" ? true : false
  rbac-enabled     = var.rbac-enabled == "YES" ? true : false
  roles            = local.rbac-enabled ? (split(",", var.rbac-roles)) : []
  scopes           = local.rbac-enabled ? (split(",", var.rbac-scopes)) : []
  combined_list = local.rbac-enabled ? flatten([
    for s in local.scopes :
    [
      for r in local.roles :
      {
        scope = s,
        role  = r
      }
    ]
  ]) : []
}
