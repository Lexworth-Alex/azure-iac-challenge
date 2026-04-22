variable "name_prefix" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "frontend_fqdn" {
  type = string
}

variable "certificate_secret_id" {
  type = string
}


variable "user_assigned_identity_id" {
  type = string
}

variable "tags" {
  type = map(string)
}
