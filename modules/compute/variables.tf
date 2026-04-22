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

variable "admin_username" {
  type = string
}

variable "public_key_path" {
  type = string
}

variable "backend_pool_id" {
  type = string
}

variable "custom_data_file_path" {
  type = string
}

variable "tags" {
  type = map(string)
}
