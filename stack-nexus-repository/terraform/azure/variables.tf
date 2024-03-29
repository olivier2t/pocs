# Cycloid variables
variable "env" {}
variable "project" {}
variable "customer" {}

# Azure variables
variable "azure_client_id" {}
variable "azure_client_secret" {}
variable "azure_subscription_id" {}
variable "azure_tenant_id" {}
variable "azure_env" {
    default = "public"
}
variable "azure_location" {
    default = "West Europe"
}
variable "keypair_public" {}
variable "vm_os_user" {}