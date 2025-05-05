variable "location" {
  type    = string
  default = "westeurope"
}

variable "storageaccount" {
  type        = string
  description = "comma separated list of storage account that needs to be created."
}

variable "resourcegroup_name" {
  type = string
}

variable "account_tier" {
  type = string
}

variable "account_replication_type" {
  type = string
}

locals {
  storageList = tolist(split(",", var.storageaccount))
}
