output "public_ip_address" {
  value = azurerm_public_ip.this.ip_address
}

output "backend_pool_id" {
  value = one([
    for pool in azurerm_application_gateway.this.backend_address_pool : pool.id
    if pool.name == "backend-pool"
  ])
}
