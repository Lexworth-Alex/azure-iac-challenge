resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_user_assigned_identity" "appgw" {
  name                = "id-appgw-${var.name_prefix}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_key_vault" "this" {
  name                       = "kv-${var.name_prefix}-${random_string.suffix.result}"
  location                   = var.location
  resource_group_name        = var.resource_group_name
  tenant_id                  = var.tenant_id
  sku_name                   = "standard"
  purge_protection_enabled   = false
  soft_delete_retention_days = 7
  enable_rbac_authorization  = true
  tags                       = var.tags
}

resource "azurerm_role_assignment" "current_user" {
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = var.object_id
}

resource "azurerm_role_assignment" "appgw_secrets_user" {
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.appgw.principal_id
}

resource "azurerm_key_vault_certificate" "this" {
  name         = var.certificate_name
  key_vault_id = azurerm_key_vault.this.id

  certificate_policy {
    issuer_parameters {
      name = "Self"
    }

    key_properties {
      exportable = true
      key_size   = 2048
      key_type   = "RSA"
      reuse_key  = true
    }

    secret_properties {
      content_type = "application/x-pkcs12"
    }

    x509_certificate_properties {
      subject            = "CN=${var.domain_name}"
      validity_in_months = 12
      key_usage = [
        "digitalSignature",
        "keyEncipherment"
      ]
      extended_key_usage = [
        "1.3.6.1.5.5.7.3.1"
      ]
    }

    lifetime_action {
      action {
        action_type = "AutoRenew"
      }
      trigger {
        days_before_expiry = 30
      }
    }
  }

  depends_on = [azurerm_role_assignment.current_user]
}
