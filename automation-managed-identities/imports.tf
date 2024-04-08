import {
  to = azurerm_resource_group.github_actions_msis
  id = "/subscriptions/a2c02b41-50aa-46b0-8994-c2268added6e/resourceGroups/gha-msis"
}

import {
  to = azurerm_resource_group.projects["website"]
  id = "/subscriptions/a2c02b41-50aa-46b0-8994-c2268added6e/resourceGroups/website"
}

import {
  to = azurerm_role_definition.static_webapp_contributor
  id = "/subscriptions/a2c02b41-50aa-46b0-8994-c2268added6e/providers/Microsoft.Authorization/roleDefinitions/3f9b7fc8-fa45-4309-8584-1fcc7ce09ea0|/subscriptions/a2c02b41-50aa-46b0-8994-c2268added6e"
}

import {
  to = azurerm_user_assigned_identity.github_actions["gha-website-identity"]
  id = "/subscriptions/a2c02b41-50aa-46b0-8994-c2268added6e/resourceGroups/gha-msis/providers/Microsoft.ManagedIdentity/userAssignedIdentities/website"
}

import {
  for_each = {
    "gha-website-identity_gha-pull-requests" = "/subscriptions/a2c02b41-50aa-46b0-8994-c2268added6e/resourceGroups/gha-msis/providers/Microsoft.ManagedIdentity/userAssignedIdentities/website/federatedIdentityCredentials/GitHub-website-PR"
    "gha-website-identity_gha-branch-main"   = "/subscriptions/a2c02b41-50aa-46b0-8994-c2268added6e/resourceGroups/gha-msis/providers/Microsoft.ManagedIdentity/userAssignedIdentities/website/federatedIdentityCredentials/GitHub-website-branch-main"
  }

  to = azurerm_federated_identity_credential.github_actions[each.key]
  id = each.value
}

import {
  for_each = {
    "gha-website-identity_dnszone"     = "/subscriptions/a2c02b41-50aa-46b0-8994-c2268added6e/resourceGroups/network/providers/Microsoft.Network/dnsZones/cloudaccelerator.dev/providers/Microsoft.Authorization/roleAssignments/758834de-1a00-4dc9-a2a7-65da2cd2a08b"
    "gha-website-identity_staticsites" = "/subscriptions/a2c02b41-50aa-46b0-8994-c2268added6e/resourceGroups/website/providers/Microsoft.Authorization/roleAssignments/703ea6bc-9f9f-4a78-b4c0-cc865cf19bd3"
    "gha-website-identity_tf"          = "/subscriptions/a2c02b41-50aa-46b0-8994-c2268added6e/resourceGroups/tf-backend/providers/Microsoft.Storage/storageAccounts/cloudacctfbackend/blobServices/default/containers/tfstate/providers/Microsoft.Authorization/roleAssignments/160699e6-7cc4-4947-984c-14b69c906df5"
  }

  to = azurerm_role_assignment.github_actions[each.key]
  id = each.value
}
