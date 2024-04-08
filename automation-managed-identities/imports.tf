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
