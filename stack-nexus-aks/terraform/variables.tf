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

# AKS variables
variable "aks_cluster_name" {}
variable "aks_resource_group_name" {}
