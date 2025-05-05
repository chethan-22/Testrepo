variable "resource_suffix" {
  default     = "001"
  description = "this is in the gateway layer "
}

# Resource Management

variable "region_short_name" {
  default     = "EU"
  description = "The location in which to deploy the resource."
}

# Release Information
variable "environment_name" {
  default     = "dev"
  description = "The three-letter environment_name name e.g. dev, test."
}

variable "environment_name_suffix" {
  default     = "dev"
  description = "The three-letter environment_name name e.g. dev, test."
}

variable "environment_name_suffix_short" {
  default     = "dev"
  description = "The three-letter environment_name name e.g. dev, test."
}

variable "project_name" {
  default     = "ejm"
  description = "The name of the project."
}

# Declare Variables
variable "aks_cluster_name" {
  default = "eJMPOCDemo"
}

variable "location" {
  default = "North Europe"
}

variable "agent_pool_count" {
  default = 1
}

variable "agent_pool_vm_size" {
  default = "Standard_DS2_v2"
}

variable "client_id" {
  default = ""
}

variable "client_secret" {
  default = ""
}

variable "subscription_id" {
  type    = string
  default = "029536b6-f6c6-4f73-af5f-565d7c4cc579"
}

variable "tenant_id" {
  type    = string
  default = "cc7f83dd-bc5a-4682-9b3e-062a900202a2"
}

variable "create_resource_group" {
  description = "Whether to create resource group and use it for all networking resources"
  default     = false
  type        = bool
}

variable "resource_group_name" {
  description = "A container that holds related resources for an Azure solution"
  default     = "RG-DEV-EU-EJM-002"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = {
    "APPLICATION DESCRIPTION" = "INTEGRATION OF DYNAMICS & THE ESTIMATOR AND INTEGRATION OF DYNAMICS & THE DOTDIGITAL"
    "APPLICATION NAME"        = "BH"
    "BUSINESS SECTOR"         = "Technology"
    "COST CENTER ID"          = "TBC"
    "EXPIRY DATE"             = "NOT REQUIRED"
    "ONLINE TIME WINDOW"      = "NOT REQUIRED"
    "REGULATORY COMPLIANCE"   = "NONE"
    "REGULATORY EXCEPTIONS"   = "NO"
    "REVIEW DATE"             = "REVIEW DATE"
  }
}