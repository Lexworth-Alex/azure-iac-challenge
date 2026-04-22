variable "resource_group_name" {
  type = string
}

variable "zone_name" {
  type = string
}

variable "app_record_name" {
  type = string
}

variable "app_public_ip" {
  type = string
}

variable "tags" {
  type = map(string)
}
