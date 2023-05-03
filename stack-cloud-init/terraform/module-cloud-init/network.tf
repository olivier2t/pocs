module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.customer}-${var.project}-${var.env}-cloud-init"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = merge(local.merged_tags, {
    Name       = "${var.customer}-${var.project}-${var.env}-cloud-init"
    role       = "nexus"
  })
}