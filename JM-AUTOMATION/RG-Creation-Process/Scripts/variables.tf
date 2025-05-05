variable "env" {
  description = "the environment name"
  type        = string
}

variable "region" {
  description = "the region name"
  type        = string
}

variable "resourcegroup" {
  type        = string
  description = "comma separated list of resource groups that needs to be created."
}

variable "adminaccount" {
  type        = string
  description = "The user principal name of the user to assign the role to"
}

variable "tags" {
  type    = map(string)
  default = {}
}


# Define a map of configurations for subscription names and locations
variable "configuration" {
  description = "A map of environment-region pairs to locations"
  type        = map(string)
  default = {
    "sbx-ap" = "eastasia"
    "dev-ap" = "eastasia"
    "acc-ap" = "eastasia"
    "prd-ap" = "southeastasia"
    "sbx-am" = "westus2"
    "dev-am" = "westus2"
    "acc-am" = "westus2"
    "prd-am" = "eastus"
    "sbx-eu" = "northeurope"
    "dev-eu" = "northeurope"
    "acc-eu" = "northeurope"
    "prd-eu" = "westeurope"
  }
}