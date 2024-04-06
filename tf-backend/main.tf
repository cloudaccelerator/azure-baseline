resource "azurerm_resource_group" "this" {
  name     = "tf-backend"
  location = local.region

  tags = local.tags
}

resource "azurerm_storage_account" "this" {
  name                = "cloudacctfbackend"
  location            = local.region
  resource_group_name = azurerm_resource_group.this.name

  account_tier = "Standard"
  access_tier  = "Cool"

  infrastructure_encryption_enabled = true
  queue_encryption_key_type         = "Account"
  table_encryption_key_type         = "Account"

  account_replication_type         = "LRS"
  cross_tenant_replication_enabled = false

  shared_access_key_enabled       = false
  default_to_oauth_authentication = true

  allow_nested_items_to_be_public = false

  tags = local.tags
}

resource "azurerm_storage_container" "this" {
  storage_account_name = azurerm_storage_account.this.name
  name                 = "tfstate"
}

locals {
  region = "westeurope"

  tags = {
    repo = var.repo
  }
}
