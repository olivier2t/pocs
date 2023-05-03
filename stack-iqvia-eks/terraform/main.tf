module "eks" {
  #####################################
  # Do not modify the following lines #
  source   = "git::${var.git_iac}"
  project  = var.project
  env      = var.env
  customer = var.customer
  #####################################

}
