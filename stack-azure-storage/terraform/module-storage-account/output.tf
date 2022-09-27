output "stg_act_name_out" {
    value = resource.azurerm_storage_account.this.name
}

output "rg_name_out" {
    value = module.rg.rg_name_out
}