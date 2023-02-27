# stack-harbor-eks

Service catalog deploying a Harbor open-source registry on AWS EKS cluster, connecting to an external PostgreSQL database.

# Details

## Pipeline

**Jobs description**

  * `terraform-plan`: Terraform job that will simply make a plan of the infrastructure's stack. It is automatically triggered upon resources changes.
  * `terraform-apply`: Terraform job similar to the plan one, but will actually create/update everything that needs to. Please see the plan diff for a better understanding. It is automatically triggered upon tfstate file changes after terraform-plan job completes.
  * `deploy-harbor`: Job mainly based on ansible which deploys and configures a Harbor Repository. It is automatically triggered upon tfstate file changes after terraform-apply job completes.
  * `terraform-destroy`: :warning: Terraform job meant to destroy the whole stack - **NO CONFIRMATION ASKED**. If triggered, the full project **WILL** be destroyed. Use with caution.

# Params

## Pipeline
|Name|Description|Type|Default|Required|
|---|---|:---:|:---:|:---:|
|`aws_access_key`|Amazon AWS access key for Terraform. See value format [here](https://docs.cycloid.io/advanced-guide/integrate-and-use-cycloid-credentials-manager.html#vault-in-the-pipeline)|`-`|`((aws.access_key))`|`True`|
|`aws_default_region`|Amazon AWS region to use for Terraform.|`-`|`eu-west-1`|`True`|
|`aws_secret_key`|Amazon AWS secret key for Terraform. See value format [here](https://docs.cycloid.io/advanced-guide/integrate-and-use-cycloid-credentials-manager.html#vault-in-the-pipeline)|`-`|`((aws.secret_key))`|`True`|
|`config_ansible_path`|Path of Ansible files in the config git repository|`-`|`($ project $)/ansible/environments`|`True`|
|`config_git_branch`|Branch to use on the config Git repository.|`-`|`config`|`True`|
|`config_git_private_key`|SSH key pair to fetch the config Git repository.|`-`|`((git.ssh_key))`|`True`|
|`config_git_repository`|Git repository URL containing the config of the stack.|`-`|`git@github.com:cycloidio/cycloid-stacks-test.git`|`True`|
|`config_terraform_path`|Path of Terraform files in the config git repository|`-`|`($ project $)/terraform/eks-helm/($ environment $)`|`True`|
|`customer`|Name of the Cycloid Organization, used as customer variable name.|`-`|`($ organization_canonical $)`|`True`|
|`cycloid_api_key`|API key to grant admin acess to Cycloid API.|`-`|`((cycloid-api-key.key))`|`True`|
|`cycloid_api_url`|Cycloid API URL.|`-`|`https://http-api.cycloid.io`|`True`|
|`eks_cluster_name`|Cluster name where to deploy the workload. The Kubernetes cluster shall exist or be created beforehand|`-`|`default`|`True`|
|`k8s_namespace`|Namespace where to deploy the workload. The Namespace shall exist or be created beforehand|`-`|`default`|`True`|
|`env`|Name of the project's environment.|`-`|`($ environment $)`|`True`|
|`project`|Name of the project.|`-`|`($ project $)`|`True`|
|`stack_ansible_path`|Path of Ansible files in the stack git repository|`-`|`stack-get-started/ansible`|`True`|
|`stack_git_branch`|Branch to use on the stack Git repository.|`-`|`master`|`True`|
|`stack_git_private_key`|SSH key pair to fetch the stack Git repository.|`-`|`((git.ssh_key))`|`True`|
|`stack_git_repository`|Git repository URL containing the stack.|`-`|`git@github.com:cycloidio/cycloid-demo-stacks.git`|`True`|
|`stack_terraform_path`|Path of Terraform files in the stack git repository|`-`|`stack-get-started/terraform/eks-helm`|`True`|
|`terraform_storage_bucket_name`|AWS S3 bucket name to store terraform remote state file.|`-`|`($ organization_canonical $)-terraform-remote-state`|`True`|
|`terraform_version`|terraform version used to execute your code.|`-`|`'1.0.5'`|`True`|

## Terraform
|Name|Description|Type|Default|Required|
|---|---|:---:|:---:|:---:|
|`eks_cluster_name`|Cluster name where to deploy the workload. The Kubernetes cluster shall exist or be created beforehand.|`-`|`default`|`False`|
|`k8s_namespace`|Namespace where to deploy the workload. The Namespace shall exist or be created beforehand.|`-`|`harbor`|`False`|
|`harbor_port`|Port where Harbor Repository service is exposed|`-`|`8081`|`False`|
|`vm_disk_size`|Disk size for the Harbor Repository (Go)|`-`|`20`|`False`|