
# Resource Group
variable "resourcegroup" {
  description = "Resource group via client payload"
  type = string
}
variable "location" {}

# Virtual Machine Configuration
variable "vmname" {
  description = "VM name via client payload"
  type = string
}
variable "vmsize" {
  description = "Sizing via client payload"
  type = string
}
variable "admin_username" {
  description = "Username for local sign-in"
  type    = string
  }
variable "admin_password" {
  description = "Password for local sign-in"
  type    = string
  }
variable "public_ip_enabled" {
  default = false
}

# Networking
variable "vnet"{
  description = "The name of the virtual network using client payload"
  type        = string  
}
variable "snet"{
  description = "The name of the subnet using client payload"
  type        = string
}

variable "vnetRG"{}

variable "assign_public_ip" {
  default = false
}

# Storage
#variable "storage_account_name" {
#  description = "Name for storage account"
#  type        = string
#}

variable "os_disk_type" {}
#variable "data_disk_count" {
#  default = 0
#}

# Image Definition
variable "image_publisher" {}
variable "image_offer" {}
variable "image_sku" {}

# Authentication
#variable "authentication_method" {}

# Tags
variable "tags" {
  type = map(string)
  default = {}
}

# Monitoring and Management
variable "enable_monitoring" {
  default = false
}
variable "enable_automation" {
  default = false
}

# Advanced Settings
variable "availability_zones_enabled" {
  default = false
}
variable "custom_script_extension" {
  default = ""
}

