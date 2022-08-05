
# Terraform module to provision AWS s3 Buckets.


## Usage

The module creates one or more s3 Buckets. Each Bucket created can have separate/unique configuration.


If you provide 1 or more items in `s3_buckets` list of maps then one s3 bucket will be created for
each of the items you provide.

Include this repository as a module in your existing terraform code:

```hcl
# Variable to store list of buckets

variable "s3_buckets" {

    default =
    [{
    name: "s3-sample-name-1",
    acl: "private",
    versioning: "Enabled",
    block_public_access: true,
    },
    {
    name: "s3-sample-name-2",
    acl: "private",
    versioning: "Disabled",
    block_public_access: true,
    },
    ...]

}

variable "environment" {
    default = "staging"
}

module "s3" {
  source                     = "git@github.com:JumiaOPS/jumia-business-terraform-modules.git//data/s3"
  s3_buckets                 = var.s3_buckets
  environment                = var.environment

}

```

