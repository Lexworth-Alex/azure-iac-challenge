output "certificate_secret_id" {
  value = azurerm_key_vault_certificate.this.secret_id
}

output "user_assigned_identity_id" {
  value = azurerm_user_assigned_identity.appgw.id
}
