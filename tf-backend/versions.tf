terraform {
  required_version = "~> 1.5.7"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.9"
    }
  }

  backend "azurerm" {
    resource_group_name  = "tf-backend"
    storage_account_name = "cloudacctfbackend"
    container_name       = "tfstate"
    key                  = "azure-baseline/tf-backend.tfstate"
    use_azuread_auth     = true
    use_oidc             = true
  }
}
