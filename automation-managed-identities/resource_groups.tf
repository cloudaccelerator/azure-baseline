resource "azurerm_resource_group" "github_actions_msis" {
  name     = "gha-msis"
  location = local.region

  tags = local.tags
}

resource "azurerm_resource_group" "projects" {
  for_each = local.gha_resource_groups

  name     = each.key
  location = each.value.location

  tags = merge(local.tags, {
    repo = "https://github.com/${each.value.repo}"
  })
}
