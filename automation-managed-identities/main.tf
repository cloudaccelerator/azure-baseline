data "azurerm_management_group" "cloudaccelerator" {
  name = "cloudaccelerator-root"
}

data "azurerm_dns_zone" "cloudaccelerator" {
  name = "cloudaccelerator.dev"
}

data "azurerm_storage_container" "terraform_backend" {
  name                 = "tfstate"
  storage_account_name = "cloudacctfbackend"
}

data "azurerm_role_definition" "terraform_backend_blob_data_contributor" {
  name  = "Terraform Backend Blob Data Contributor"
  scope = data.azurerm_storage_container.terraform_backend.resource_manager_id
}

locals {
  region = "westeurope"

  tags = {
    repo = replace(var.repo, "/^git://(.*)\\.git$/", "https://$1")
  }

  gha_resource_groups = {
    website = {
      location = local.region
      repo     = "cloudaccelerator/website"
    }
  }

  gha_managed_identities = {
    "gha-website-identity" = {
      repository = local.gha_resource_groups["website"].repo

      federated_credentials = [
        {
          name   = "gha-pull-requests"
          entity = "pull_request"
        },
        {
          name   = "gha-branch-main"
          entity = "ref:refs/heads/main"
        }
      ]

      role_assignments = [
        {
          "_key"               = "dnszone"
          description          = "Create DNS records for static web app."
          role_definition_name = "DNS Zone Contributor"
          scope                = data.azurerm_dns_zone.cloudaccelerator.id
        },
        {
          "_key"           = "staticsites"
          description      = "Manage static web apps."
          role_defition_id = azurerm_role_definition.static_webapp_contributor.role_definition_resource_id
          scope            = azurerm_resource_group.projects["website"].id
        },
        {
          "_key"           = "tf"
          description      = "Access Terraform backend."
          role_defition_id = data.azurerm_role_definition.terraform_backend_blob_data_contributor.role_definition_id
          scope            = data.azurerm_storage_container.terraform_backend.resource_manager_id
        }
      ]
    }
  }
}
