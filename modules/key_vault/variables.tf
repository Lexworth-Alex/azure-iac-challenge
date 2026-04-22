variable "name_prefix" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "object_id" {
  type = string
}

variable "certificate_name" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "tags" {
  type = map(string)
}
