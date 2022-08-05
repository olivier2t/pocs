module "s3" {
  source                     = "./module-s3"
  # source                     = "OR PATH TO THE REMOTE TF MODULE"
  s3_buckets                 = "Injected by Cycloid StackForms"
  s3_bucket_objects          = "Injected by Cycloid StackForms"
  environment                = var.env
}