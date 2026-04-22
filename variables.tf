variable "location" {
  type    = string
  default = "westeurope"
}

variable "project_name" {
  type    = string
  default = "alexweb"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "admin_username" {
  type    = string
  default = "azureuser"
}

variable "public_key_path" {
  type = string
}

variable "db_admin_username" {
  type    = string
  default = "pgadmin"
}

variable "db_admin_password" {
  type      = string
  sensitive = true
}

variable "domain_name" {
  type    = string
  default = "demo.local"
}