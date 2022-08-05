module "s3" {
  source                     = "./module-s3"
  s3_buckets                 = "Injected by StackForms"
  s3_bucket_objects          = "Injected by StackForms"
  environment                = var.env
}