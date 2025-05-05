variable "env" {
  description = "The environment name"
  type        = string
}

variable "region" {
  description = "The region name"
  type        = string
}

# Define a map of configurations for subscription names and locations
variable "configuration" {
  description = "A map of environment-region pairs to subscription names"
  type        = map(string)

  default = {
    "sbx-ap" = "sub-sandbox"
    "dev-ap" = "sub-dev-ap"
    "acc-ap" = "sub-acc-o-ap"
    "prd-ap" = "sub-prd-o-ap"
    "sbx-am" = "sub-sandbox"
    "dev-am" = "sub-dev-am"
    "acc-am" = "sub-acc-o-am"
    "prd-am" = "sub-prd-o-am"
    "sbx-eu" = "sub-sandbox"
    "dev-eu" = "sub-dev-eu"
    "acc-eu" = "sub-acc-o-eu"
    "prd-eu" = "sub-prd-o-eu"
  }
}
