variable "location" {
  type    = string
  default = "westeurope"
}

variable "resourcegroup_name" {
  type = string
}

variable "sql_version" {
  description = "Version of SQL server"
  default = "12.0"
}
variable "mssql_server_name" {
  type        = string
}

variable "mssql_db_name" {
  type        = string
}
variable "sku_name" {
  type = string
}

variable "administrator_login" {
  description = "Username for administrator login"
  type    = string
}

variable "administrator_login_password" {
  description = "Password for administrator login"
  type    = string
}

variable "mssql_database_required" {
  type        = bool
  description = "If the SQL Database is required or not"
  default     = true
}

locals {
  mssqlList = tolist(split(",", var.mssql_server_name))
}
