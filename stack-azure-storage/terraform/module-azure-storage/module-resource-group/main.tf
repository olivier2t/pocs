resource "azurerm_resource_group" "this" {
  
  #this section mirrors the variables.tf
  #these are the default variables for all resources
    name                    = "rg-${var.appName}"
    location                = var.location
    # tags = {
    #     env         = var.environment
    #     created_by  = var.createdby
    # }
    # Changing tags to reflect usual ways of working in Cycloid stacks
    tags = merge(local.merged_tags, {
        environment = var.environment
        created_by  = var.createdby
    })
  #this section define resource specific settings
}

resource "azurerm_management_lock" "this" {
  name       = "resource-group-lock"
  scope      = azurerm_resource_group.this.id
  lock_level = "CanNotDelete"
  notes      = "This RG and resource within are locked from deletion"
}
