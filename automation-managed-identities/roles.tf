resource "azurerm_role_definition" "static_webapp_contributor" {
  name        = "Static Web App Contributor"
  description = "Lets you manage static web apps."
  scope       = data.azurerm_management_group.cloudaccelerator.id

  permissions {
    actions = [
      "Microsoft.Web/freeTrialStaticWebApps/*",
      "Microsoft.Web/locations/previewstaticsiteworkflowfile/action",
      "Microsoft.Web/locations/operationResults/read",
      "Microsoft.Web/staticSites/*",
      "Microsoft.Resources/subscriptions/resourceGroups/deployments/*",
      "Microsoft.Resources/subscriptions/resourceGroups/read",
      "Microsoft.Resources/subscriptions/resourceGroups/resources/read"
    ]
  }
}
