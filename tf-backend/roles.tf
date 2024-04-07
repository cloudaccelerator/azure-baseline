resource "azurerm_role_definition" "tf_backend_blob_data_contributor" {
  name        = "Terraform Backend Blob Data Contributor"
  description = "Allows for read, write access, except delete, to Azure Storage blob containers data."
  scope       = azurerm_storage_container.this.resource_manager_id

  permissions {
    actions = [
      "Microsoft.Storage/storageAccounts/blobServices/containers/read",
      "Microsoft.Storage/storageAccounts/blobServices/generateUserDelegationKey/action"
    ]

    data_actions = [
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read",
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/write",
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/move/action",
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/add/action"
    ]
  }
}
