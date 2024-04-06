import {
  to = azurerm_resource_group.this
  id = "/subscriptions/a2c02b41-50aa-46b0-8994-c2268added6e/resourceGroups/tf-backend"
}

import {
  to = azurerm_storage_account.this
  id = "/subscriptions/a2c02b41-50aa-46b0-8994-c2268added6e/resourceGroups/tf-backend/providers/Microsoft.Storage/storageAccounts/cloudacctfbackend"
}

import {
  to = azurerm_storage_container.this
  id = "https://cloudacctfbackend.blob.core.windows.net/tfstate"
}
