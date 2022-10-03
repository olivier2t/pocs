# stack-azure-storage

This stack deploys and manages an Azure Storage Account.

# Requirements

In order to run this task, couple elements are required within the infrastructure:

  * Having an Azure Storage Account to store Terraform remote states [Here](https://docs.microsoft.com/en-us/azure/storage/common/storage-account-create?toc=%2Fazure%2Fstorage%2Fblobs%2Ftoc.json&tabs=azure-portal)


# Details

**Jobs description**

  * `terraform-plan`: Terraform job that will simply make a plan of the stack.
  * `terraform-apply`: Terraform job similar to the plan one, but will actually create/update everything that needs to. Please see the plan diff for a better understanding.
  * `terraform-destroy`: :warning: Terraform job meant to destroy the whole stack - **NO CONFIRMATION ASKED**. If triggered, the full project **WILL** be destroyed. Use with caution.

## Pipeline Params

|Name|Description|Type|Default|Required|
|---|---|:---:|:---:|:---:|
|`azure_client_id`|Azure client ID to use for Terraform.|`-`|`((azure.client_id))`|`True`|
|`azure_client_secret`|Azure client secret to use for Terraform.|`-`|`((azure.client_secret))`|`True`|
|`azure_env`|Azure environment to use for Terraform. Can be either `public`, `usgovernment`, `german` or `china`.|`-`|`public`|`True`|
|`azure_subscription_id`|Azure subscription ID to use for Terraform.|`-`|`((azure.subscription_id))`|`True`|
|`azure_tenant_id`|Azure tenant ID to use for Terraform.|`-`|`((azure.tenant_id))`|`True`|
|`config_git_branch`|Branch to use on the config Git repository.|`-`|`($ cr_branch $)`|`True`|
|`config_git_private_key`|SSH key pair to fetch the config Git repository.|`-`|`((git.ssh_key))`|`True`|
|`config_git_repository`|Git repository URL containing the config of the stack.|`-`|`($ cr_url $)`|`True`|
|`config_terraform_path`|Path of Terraform files in the config git repository|`-`|`($ project $)/terraform/($ environment $)`|`True`|
|`customer`|Name of the Cycloid Organization, used as customer variable name.|`-`|`($ organization_canonical $)`|`True`|
|`env`|Name of the project's environment.|`-`|`($ environment $)`|`True`|
|`project`|Name of the project.|`-`|`($ project $)`|`True`|
|`stack_git_branch`|Branch to use on the stack Git repository.|`-`|`($ scs_branch $)`|`True`|
|`stack_git_private_key`|SSH key pair to fetch the stack Git repository.|`-`|`((git.ssh_key))`|`True`|
|`stack_git_repository`|Git repository URL containing the stack.|`-`|`($ scs_url $)`|`True`|
|`stack_terraform_path`|Path of Terraform files in the stack git repository|`-`|`stack-azure-storage/terraform`|`True`|
|`terraform_resource_group_name`|Azure Resource Group of the Storage Account to use to store terraform remote state file.|`-`|`($ organization_canonical $)-terraform`|`True`|
|`terraform_storage_account_key`|Azure Storage Account key to use to store terraform remote state file.|`-`|`((azure_storage.access_key))`|`True`|
|`terraform_storage_account_name`|Azure Storage Account name to use to store terraform remote state file.|`-`|`((azure_storage.account_name))`|`True`|
|`terraform_storage_container_name`|Azure Storage container name to store terraform remote state file.|`-`|`($ organization_canonical $)`|`True`|
|`terraform_storage_container_path`|Azure Storage container path to store terraform remote state file.|`-`|`($ project $)/($ environment $)`|`True`|
|`terraform_version`|terraform version used to execute your code.|`-`|`'1.3.0'`|`True`|

## Terraform Params

|Name|Description|Type|Default|Required|
|---|---|:---:|:---:|:---:|
|`access_tier`|Default data access tier. Must be either 'Hot', or 'Cool'.|`-`|`"Hot"`|`False`|
|`account_kind`|Type of storage account. Must be either 'FileStorage', 'Storage', or 'StorageV2'.|`-`|`"StorageV2"`|`False`|
|`account_replication_type`|Data redundancy. Must be either 'LRS', or 'GRS'."|`-`|`"LRS"`|`False`|
|`account_tier`|Performance tier. Must be either 'Standard', or 'Premium'.|`-`|`"Standard"`|`False`|
|`appName`|Name of the application. Must be between 3 and 24 characters, be lower case and only contain characters or numbers.|`-`|`""`|`False`|
|`createdby`|Name of who created the resource.|`-`|`""`|`False`|
|`environment`|Type of environment. Must be either 'prod', 'test', or 'dev' and lower case.|`-`|`"test"`|`False`|
|`location`|Azure location of the resource group. Must be either 'west europe', 'north europe', or 'east us' and lower case.|`-`|`"west europe"`|`False`|