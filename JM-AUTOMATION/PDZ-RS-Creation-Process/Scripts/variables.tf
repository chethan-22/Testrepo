variable "resource_group_name" {
  description = "The name of the resource group where the private DNS zone is located"
  type        = string
  default     = "rg-hub-eu-privatedns-001"
}

variable "name" {
  description = "The name of the A record set you want to create"
  type        = string
  default     = ""
}

variable "ttl" {
  description = "The time-to-live of the A record set"
  type        = number
  default     = 900
}

variable "type" {
  description = "The type of the record set you want to create"
  type        = string
  default     = ""
}

variable "ips" {
  description = "The IP addresses that the A record set should point to"
  type        = list(string)
  default     = []
}

variable "cname" {
  description = "The hostname that the CNAME record should point to"
  type        = string
  default     = ""
}
