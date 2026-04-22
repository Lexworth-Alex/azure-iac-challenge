variable "name_prefix" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "delegated_subnet_id" {
  type = string
}

variable "private_dns_zone_id" {
  type = string
}

variable "private_dns_zone_name" {
  type = string
}

variable "vnet_id" {
  type = string
}

variable "administrator_login" {
  type = string
}

variable "administrator_password" {
  type      = string
  sensitive = true
}

variable "tags" {
  type = map(string)
}
