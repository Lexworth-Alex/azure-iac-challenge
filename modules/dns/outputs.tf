output "zone_name" {
  value = azurerm_dns_zone.this.name
}

output "fqdn" {
  value = azurerm_dns_a_record.app.fqdn
}
