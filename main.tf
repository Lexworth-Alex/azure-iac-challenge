locals {
  name_prefix = "${var.project_name}-${var.environment}"

  tags = {
    project     = var.project_name
    environment = var.environment
    managed_by  = "terraform"
  }
}

module "resource_group" {
  source   = "./modules/resource_group"
  name     = "rg-${local.name_prefix}"
  location = var.location
  tags     = local.tags
}

module "network" {
  source              = "./modules/network"
  name_prefix         = local.name_prefix
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  tags                = local.tags
}

module "key_vault" {
  source              = "./modules/key_vault"
  name_prefix         = local.name_prefix
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  object_id           = data.azurerm_client_config.current.object_id
  certificate_name    = "app-cert"
  domain_name         = "app.${var.domain_name}"
  tags                = local.tags
}

module "compute" {
  source                = "./modules/compute"
  name_prefix           = local.name_prefix
  location              = module.resource_group.location
  resource_group_name   = module.resource_group.name
  subnet_id             = module.network.web_subnet_id
  admin_username        = var.admin_username
  public_key_path       = var.public_key_path
  backend_pool_id       = module.application_gateway.backend_pool_id
  custom_data_file_path = "${path.root}/scripts/cloud-init-nginx.sh"
  tags                  = local.tags
}

module "database" {
  source                 = "./modules/database"
  name_prefix            = local.name_prefix
  location               = module.resource_group.location
  resource_group_name    = module.resource_group.name
  delegated_subnet_id    = module.network.db_subnet_id
  private_dns_zone_id    = module.network.postgres_private_dns_zone_id
  private_dns_zone_name  = module.network.postgres_private_dns_zone_name
  vnet_id                = module.network.vnet_id
  administrator_login    = var.db_admin_username
  administrator_password = var.db_admin_password
  tags                   = local.tags
}

module "application_gateway" {
  source                    = "./modules/application_gateway"
  name_prefix               = local.name_prefix
  location                  = module.resource_group.location
  resource_group_name       = module.resource_group.name
  subnet_id                 = module.network.appgw_subnet_id
  frontend_fqdn             = "app.${var.domain_name}"
  certificate_secret_id     = module.key_vault.certificate_secret_id
  user_assigned_identity_id = module.key_vault.user_assigned_identity_id
  tags                      = local.tags
}

module "dns" {
  source              = "./modules/dns"
  resource_group_name = module.resource_group.name
  zone_name           = var.domain_name
  app_record_name     = "app"
  app_public_ip       = module.application_gateway.public_ip_address
  tags                = local.tags
}

data "azurerm_client_config" "current" {}
