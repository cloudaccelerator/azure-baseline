resource "azurerm_user_assigned_identity" "github_actions" {
  for_each = local.gha_managed_identities

  name                = each.key
  location            = local.region
  resource_group_name = azurerm_resource_group.github_actions_msis.name

  tags = local.tags
}

resource "azurerm_federated_identity_credential" "github_actions" {
  for_each = merge([
    for managed_identity, properties in local.gha_managed_identities : {
      for federated_credential in properties.federated_credentials :
      "${managed_identity}_${federated_credential.name}" => merge(
        {
          principal_id = azurerm_user_assigned_identity.github_actions[managed_identity].id
          repository   = properties.repository
        },
        federated_credential
      )
    }
  ]...)

  resource_group_name = azurerm_resource_group.github_actions_msis.name
  parent_id           = each.value.principal_id
  name                = each.value.name

  issuer   = "https://token.actions.githubusercontent.com"
  audience = ["api://AzureADTokenExchange"]
  subject  = "repo:${each.value.repository}:${each.value.entity}"
}

resource "azurerm_role_assignment" "github_actions" {
  for_each = merge([
    for managed_identity, properties in local.gha_managed_identities : {
      for role_assignment in properties.role_assignments :
      "${managed_identity}_${role_assignment["_key"]}" => merge(
        {
          principal_id = azurerm_user_assigned_identity.github_actions[managed_identity].principal_id
        },
        role_assignment
      )
    }
  ]...)

  principal_id         = each.value.principal_id
  role_definition_id   = try(each.value.role_definition_id, null)
  role_definition_name = try(each.value.role_definition_name, null)
  scope                = each.value.scope
  description          = each.value.description
}
