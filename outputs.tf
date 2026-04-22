output "application_url" {
  value = "https://app.${var.domain_name}"
}

output "application_gateway_public_ip" {
  value = module.application_gateway.public_ip_address
}

output "database_fqdn" {
  value = module.database.db_fqdn
}

output "vmss_name" {
  value = module.compute.vmss_name
}