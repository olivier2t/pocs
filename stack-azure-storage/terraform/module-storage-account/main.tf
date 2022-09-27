resource "azurerm_storage_account" "this" {
    #these are the default variables for all resources
    location        = var.location
    # tags = {
    #     env         = var.environment
    #     created_by  = var.createdby
    # }
    # Changing tags to reflect usual ways of working in Cycloid stacks
    tags = merge(local.merged_tags, {
        environment = var.environment
        created_by  = var.createdby
    })

    #this section define resource specific settings that are variables
    account_kind                      = var.account_kind //Valid options are 'BlogStorage', 'BlockBlobStorage', 'FileStorage', 'Storage', 'StorageV2' (optional)
    account_tier                      = var.account_tier //performance; stanard is recommened for most scenarios. Valid options are 'Stanard', 'Premium' (required)
    account_replication_type          = var.account_replication_type //redundancy; valid options are 'LRS', 'GRS', 'RAGRS', 'ZRS', 'GZRS', 'RSGZRS' (required)
    access_tier                       = var.access_tier //performance. valid options are 'hot', 'cool' (optional)
        
    #this section defines what settings are set in code and not changeable
    name                              = "st${lower(var.appName)}${random_string.random.result}" //must be unique across all existing storage account names in Azure. It must be 3 to 24 characters long, and can contain only lowercase letters and numbers. (required)
    resource_group_name               = module.rg.azurerm_resource_group.name //the name of the resource group where the resource will exist (required)
    enable_https_traffic_only         = true //secure transfer enabled (mandatory)
    min_tls_version                   = "TLS1_2" //minimum tls 1.2 is (mandatory)
  
}

#this generates a random string of letters and numbers that is used to build the storage account name
resource "random_string" "random" {
    length              = 6
    special             = false
    upper               = false
}
