# stack-terraformlz

Azure Landing Zone with Terraform

# Details

**Jobs description**

  * `terraform-plan`: Terraform job that will simply make a plan of the infrastructure's stack. It is automatically triggered upon resources changes.
  * `terraform-apply`: Terraform job similar to the plan one, but will actually create/update everything that needs to. Please see the plan diff for a better understanding. It is automatically triggered upon tfstate file changes after terraform-plan job completes.
  * `terraform-destroy`: :warning: Terraform job meant to destroy the whole stack - **NO CONFIRMATION ASKED**. If triggered, the full project **WILL** be destroyed. Use with caution.
